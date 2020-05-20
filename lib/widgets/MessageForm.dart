import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  String hintText = 'Send message';
  Function(String value) onSubmitted = (String value) {};

  MessageForm({Key key, this.hintText, this.onSubmitted}) : super(key: key);

  @override
  MessageFormState createState() => MessageFormState();
}

class MessageFormState extends State<MessageForm> {
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bool isEmptyForm = _textController.text.length <= 0;

    return Container(
      padding: EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: isEmptyForm ? null : widget.onSubmitted,
              decoration: InputDecoration.collapsed(hintText: widget.hintText),
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
                  if (isEmptyForm) return;
                  widget.onSubmitted(_textController.text);
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