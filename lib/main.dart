import 'package:flutter/material.dart';
import './pages/list.dart';
import './pages/chat.dart';

void main() => {
  runApp(MyApp())
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => ListPage(),
        '/chat': (BuildContext context) => ChatPage(),
      },
    );
  }
}
