import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String _name = 'kimulaco';

  ChatMessage({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(_name[0])),
          ),
          Text(text),
        ],
      ),
    );
  }
}
