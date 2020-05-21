import 'dart:async';
import 'package:flutter/material.dart';
import './Chat.dart';
import '../widgets/UserIcon.dart';
import '../utils/Users.dart';

class ListPage extends StatefulWidget {
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  final Set<String> _saved = Set<String>();
  List<Map<String, dynamic>> users = [];

  Future _getUsersList() async {
    final List<Map<String, dynamic>> usersList = await getUsersList();
    setState(() {
      users = usersList;
    });
  }

  Widget _createUserLink(user) {
    final bool alreadySaved = _saved.contains(user['id']);

    return ListTile(
      leading: UserIcon(user),
      title: Text(
        user['name'],
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
              _saved.remove(user['id']);
            } else {
              _saved.add(user['id']);
            }
          });
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: ChatPageArg(
            userId: user['id'],
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
            color: Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: (users.length * 2),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _createUserLink(users[i ~/ 2]);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUsersList();
  }
}
