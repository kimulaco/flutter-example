import 'dart:async';
import 'package:flutter/material.dart';
import './Chat.dart';
import '../widgets/UserIcon.dart';
import '../utils/Friends.dart';

class ListPage extends StatefulWidget {
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  final Set<String> _saved = Set<String>();
  List<Map<String, dynamic>> friends = [];

  Future _getFriendList() async {
    final List<Map<String, dynamic>> friendList = await getFriendList();
    setState(() {
      friends = friendList;
    });
  }

  Widget _createFriendLink(friend) {
    final bool alreadySaved = _saved.contains(friend['id']);

    return ListTile(
      leading: UserIcon(friend),
      title: Text(
        friend['name'],
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: IconButton(
        icon: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onPressed: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(friend['id']);
            } else {
              _saved.add(friend['id']);
            }
          });
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: ChatPageArg(
            friendId: friend['id'],
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: (friends.length * 2),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _createFriendLink(friends[i ~/ 2]);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getFriendList();
  }
}
