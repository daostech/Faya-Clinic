import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/chat_message.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/chat/chat_controller.dart';
import 'package:faya_clinic/screens/chat/components/app_bar_chat.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/input_border_radius.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller;
  const ChatScreen._({Key? key, required this.controller}) : super(key: key);

  static Future create(BuildContext context) {
    final authRepo = Provider.of<AuthRepositoryBase>(context, listen: false);
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => ChangeNotifierProvider<ChatController>(
          create: (_) => ChatController(authRepository: authRepo)..init(),
          builder: (ctx, child) {
            return Consumer<ChatController>(
              builder: (context, controller, _) => ChatScreen._(
                controller: controller,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRTL = TransUtil.isArLocale(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // search app bar container
            top: 0,
            right: 0,
            left: 0,
            height: size.height * 0.2,
            child: AppBarChat(),
          ),
          Positioned(
            // sections container
            top: size.height * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
            // child: null,
            child: SectionCornerContainer(
              title: "",
              child: Column(
                children: [
                  Expanded(
                    child: buildChatMessagesStreamBuilder(),
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorGreyLight,
                      boxShadow: [
                        BoxShadow(
                          color: colorGreyDark,
                          offset: Offset(0.0, -0.5),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(marginStandard),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RadiusBorderedInput(
                              controller: controller.messageTxtController,
                              hintText: TransUtil.trans("hint_write_message"),
                              initialValue: null,
                              onChanged: (_) {},
                              isReadOnly: controller.isLoading,
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.onSendMessageClick(controller.messageTxtController.text),
                            icon: Icon(
                              Icons.send,
                              color: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChatMessagesList() {
    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (controller.chatMessages.isEmpty) {
      return Center(
        child: Text(TransUtil.trans("msg_no_messages_yet")),
      );
    }
    return ListView.builder(
      itemCount: controller.chatMessages.length,
      reverse: true,
      itemBuilder: (ctx, indx) {
        final message = controller.chatMessages[indx];
        final sentByMe = controller.sentByMe(message.roomname ?? "");
        if (controller.isJoinMessage(message.type ?? "")) {
          return Center(child: Text(message.message!));
        }
        return ChatBubble(
          message: controller.chatMessages[indx].message ?? "msg",
          sent: indx % 2 == 0,
          isSender: sentByMe,
        );
      },
    );
  }

  Widget buildChatMessagesStreamBuilder() {
    return StreamBuilder<DatabaseEvent>(
        stream: controller.chatMessagesStream,
        builder: (context, snapshot) {
          print("snapshot connectionState: ${snapshot.connectionState}");
          print("snapshot hasError: ${snapshot.hasError}");
          print("snapshot hasData: ${snapshot.hasData}");
          print("snapshot data: ${snapshot.data}");
          print("snapshot data toString: ${snapshot.data?.snapshot.children.toString()}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text(TransUtil.trans("msg_no_data")));
          }

          final dataSnapshots = snapshot.data!.snapshot.value as Map<Object?, Object?>?;

          final chatMessages = <ChatMessage>[];
          if (dataSnapshots != null) {
            for (int i = 0; i < dataSnapshots.length; i++) {
              print("children ${dataSnapshots.values.elementAt(i)}");
              final jj = jsonEncode(dataSnapshots.values.elementAt(i));
              chatMessages.add(chatMessageFromJson(jj));
              print("chatMessages $i ${chatMessages.elementAt(i).toJson()}");
            }
          }
          chatMessages.sort((b, a) => a.date!.compareTo(b.date!));

          if (chatMessages.isEmpty) {
            return Center(
              child: Text(TransUtil.trans("msg_no_messages_yet")),
            );
          }
          return ListView.builder(
            itemCount: chatMessages.length,
            reverse: true,
            itemBuilder: (ctx, indx) {
              final message = chatMessages[indx];
              final sentByMe = controller.sentByMe(message.nickname ?? "");
              if (controller.isJoinMessage(message.type ?? "")) {
                return Center(child: Text(message.message!));
              }
              return BubbleSpecialThree(
                text: chatMessages[indx].message ?? "",
                sent: false,
                color: sentByMe ? colorPrimary : colorPrimaryLight,
                isSender: sentByMe,
              );
            },
          );
        });
  }
}
