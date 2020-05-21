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
    final dbPath = join(await getDatabasesPath(), dbName);
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

  Future<void> delete() async {
    final dbPath = join(await getDatabasesPath(), dbName);
    await deleteDatabase(dbPath);
  }

  Future<void> insertRecode(Chat chat) async {
    await db.insert(
      tableName,
      chat.toMap(),
    );
  }

  Future<void> updateRecode(int id, Chat chat) async {
    await db.update(
      tableName,
      chat.toMap(),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> deleteRecode(List<int> id) async {
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: id,
    );
  }

  Future<List<Chat>> getAllRecode() async {
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return _mapListToChatList(maps);
  }

  Future<List<Chat>> getRecode(List<int> id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id IN (${id.join(', ')})',
    );
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
