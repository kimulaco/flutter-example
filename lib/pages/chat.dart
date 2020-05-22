import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/ChatMessage.dart';
import '../widgets/MessageForm.dart';
import '../utils/User.dart';
import '../utils/ChatDB.dart';
import '../utils/Friends.dart';

class ChatPageArg {
  final String friendId;

  ChatPageArg({
    @required this.friendId,
  });
}

class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];
  final User user = User();
  Map<String, dynamic> friend = {};
  String userName;
  ChatDB chatDB;

  Future _getFriend(String userId) async {
    final Map<String, dynamic> friendData = await getFriend(userId);
    setState(() {
      friend = friendData;
    });
  }

  Future _getChatMessage() async {
    chatDB = ChatDB();
    await chatDB.open();
    final List<Chat> chatList = await chatDB.getAll();
    setState(() {
      chatList.forEach((Chat chat) {
        _messages.add(chat.message);
      });
    });
  }

  Future _setUser() async {
    await user.open();
    final _user = await user.get();
    setState(() {
      userName = _user['name'];
    });
  }

  Widget _messageList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemCount: _messages.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: ChatMessage(
            text: _messages[i],
            userName: userName,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ChatPageArg arg = ModalRoute.of(context).settings.arguments;

    _getFriend(arg.friendId);

    return Scaffold(
      appBar: AppBar(
        title: Text(friend.containsKey('name') ? friend['name']  : ''),
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
              chatDB.insert(Chat(
                message: value,
              ));
              setState(() {
                _messages.add(value);
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getChatMessage();
    _setUser();
  }
}
