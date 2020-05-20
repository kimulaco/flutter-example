import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/ChatMessage.dart';
import '../widgets/MessageForm.dart';
import '../utils/Users.dart';

class ChatPageArg {
  final String userId;

  ChatPageArg({
    @required this.userId,
  });
}

class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];
  Map<String, dynamic> _user = {};

  Future _getUser(String userId) async {
    final Map<String, dynamic> user = await getUser(userId);
    setState(() {
      _user = user;
    });
  }

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
    final ChatPageArg arg = ModalRoute.of(context).settings.arguments;

     _getUser(arg.userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(_user.containsKey('name') ? _user['name']  : ''),
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
