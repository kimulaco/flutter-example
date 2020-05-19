import 'package:flutter/material.dart';

class MessageForm extends StatelessWidget {
  final String hintText;
  final Function(String value) onSubmitted;
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  MessageForm({
    this.hintText,
    this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: onSubmitted,
              decoration: InputDecoration.collapsed(hintText: hintText),
              focusNode: _focusNode,
            ),
          ),
          IconTheme(
            data: IconThemeData(color: Theme.of(context).accentColor),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_textController.text.length <= 0) return;
                  onSubmitted(_textController.text);
                  _textController.clear();
                  _focusNode.requestFocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}