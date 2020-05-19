import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final List<String> _messages = [];

  String _userName = '';

  void _handleSubmitted(String message) {
    setState(() {
      _messages.add(message);
      _textController.clear();
    });
  }

  Widget _messageForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _textController,
        onSubmitted: _handleSubmitted,
        decoration: InputDecoration.collapsed(hintText: 'Send a message'),
      ),
    );
  }

  Widget _messageList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(_messages[i]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _userName = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_userName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _messageForm(),
            Expanded(
              child: _messageList(),
            ),
          ],
        ),
      ),
    );
  }
}
