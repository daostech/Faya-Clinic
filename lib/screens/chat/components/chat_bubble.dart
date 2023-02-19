import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final bool sent;
  const ChatBubble({Key? key, required this.message, required this.isSender, required this.sent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      text: message,
      isSender: isSender,
      color: colorPrimaryLight,
      tail: true,
      textStyle: TextStyle(
        fontSize: fontSizeStandard,
        color: Colors.black,
      ),
    );
  }
}
