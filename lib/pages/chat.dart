import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  String userName = '';

  @override
  Widget build(BuildContext context) {
    userName = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text('chat'),
      ),
    );
  }
}
