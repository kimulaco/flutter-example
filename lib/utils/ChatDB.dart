import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

class ChatDB {
  String dbName;
  String tableName;
  Database db;

  ChatDB(this.dbName, this.tableName);

  Future<void> open() async {
    final String dbPath = join(await getDatabasesPath(), dbName);
    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database _db, version) {
        return _db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            message TEXT
          )
        ''');
      },
    );
  }

  Future<void> insert(Chat chat) async {
    await db.insert(
      tableName,
      chat.toMap(),
    );
  }

  Future<List<Chat>> getAll() async {
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    if (maps.length <= 0) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return Chat(
        id: maps[i]['id'],
        message: maps[i]['message'],
      );
    });
  }
}
