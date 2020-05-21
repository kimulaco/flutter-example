import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String userName;

  ChatMessage({
    @required this.text,
    @required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: userName == null ? null : Text(userName[0])
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
