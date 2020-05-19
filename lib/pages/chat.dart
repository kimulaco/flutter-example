import 'package:flutter/material.dart';
import '../widgets/ChatMessage.dart';
import '../widgets/MessageForm.dart';

class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];

  String _userName = '';

  Widget _messageList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemCount: _messages.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: ChatMessage(text: _messages[i]),
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
      body: Column(
        children: [
          Expanded(
            child: _messageList(),
          ),
          Divider(),
          MessageForm(
            hintText: 'Send message',
            onSubmitted: (String value) {
              setState(() {
                _messages.add(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
