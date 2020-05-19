import 'package:flutter/material.dart';
import './chat.dart';

final List<String> users = <String>[
  'Sam Porter Bridges',
  'Clifford Cliff Unger',
  'Deadman',
  'Fragile',
  'Samantha America Strand',
  'Higgs Monaghan',
  'Die-Hardman',
  'Heartman',
  'Bridget Strand',
];

class ListPage extends StatefulWidget {
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  final Set<String> _saved = Set<String>();

  Widget _createUserLink(String userName) {
    final bool alreadySaved = _saved.contains(userName);

    return ListTile(
      title: Text(
        userName,
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
              _saved.remove(userName);
            } else {
              _saved.add(userName);
            }
          });
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: ChatPageArg(
            userName: userName,
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
}
