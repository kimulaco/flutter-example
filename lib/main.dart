import 'package:flutter/material.dart';
import './pages/List.dart';
import './pages/Chat.dart';
import './pages/Settings.dart';
import './utils/Color.dart';

void main() => {
  runApp(MyApp())
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primaryColor: hexToColor('#3c3f65'),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => ListPage(),
        '/chat': (BuildContext context) => ChatPage(),
        '/settings': (BuildContext context) => SettingsPage(),
      },
    );
  }
}
