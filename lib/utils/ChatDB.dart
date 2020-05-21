import 'dart:async';
import './DatabaseProvider.dart';

class Chat {
  final int id;
  final String message;

  Chat({this.id, this.message});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
    };
  }
}

class ChatDB extends DatabaseProvider {
  ChatDB() {
    databaseName = 'chat.db';
    tableName = 'chat';
    tableExecute = '''
      id INTEGER PRIMARY KEY,
      message TEXT
    ''';
  }

  Future<void> insert(Chat chat) async {
    await insertRecode(chat.toMap());
  }

  Future<List<Chat>> getAll() async {
    final List<Map<String, dynamic>> maps = await getAllRecode();
    return _mapListToChatList(maps);
  }

  Future<List<Chat>> get(List<int> id) async {
    final List<Map<String, dynamic>> maps = await getRecode(id);
    return _mapListToChatList(maps);
  }

  List<Chat> _mapListToChatList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Chat(
        id: maps[i]['id'],
        message: maps[i]['message'],
      );
    });
  }
}
