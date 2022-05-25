import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/chat/chat_controller.dart';
import 'package:faya_clinic/screens/chat/components/app_bar_chat.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_search.dart';
import 'package:faya_clinic/widgets/input_border_radius.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller;
  const ChatScreen._({Key key, this.controller}) : super(key: key);

  static Future create(BuildContext context) {
    final authRepo = Provider.of<AuthRepositoryBase>(context, listen: false);
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => ChangeNotifierProvider<ChatController>(
          create: (_) => ChatController(authRepository: authRepo),
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
                    child: ListView.builder(
                      itemCount: 25,
                      reverse: true,
                      itemBuilder: (ctx, indx) {
                        return ChatBubble(
                          message: "test $indx",
                          sent: indx % 2 == 0,
                          isSender: indx % 5 == 0,
                        );
                      },
                    ),
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
                              onChanged: (value) {},
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
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
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 80,
          //     decoration: BoxDecoration(
          //       color: colorGreyLight,
          //       boxShadow: [
          //         BoxShadow(
          //           color: colorGreyDark,
          //           offset: Offset(0.0, -0.5),
          //           blurRadius: 1.0,
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: RadiusBorderedInput(
          //             hintText: TransUtil.trans("hint_write_message"),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
