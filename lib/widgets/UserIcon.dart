import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  final Map user;

  UserIcon(this.user);

  @override
  Widget build(BuildContext context) {
    if (user.containsKey('iconUrl') && user['iconUrl'] != '') {
      return CircleAvatar(
        backgroundImage: AssetImage(user['iconUrl']),
      );
    }
    return CircleAvatar(child: Text(user['name'][0]));
  }
}
