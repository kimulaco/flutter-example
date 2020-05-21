import 'dart:async';
import './DatabaseProvider.dart';

class User extends DatabaseProvider {
  final int userId = 1;
  String _name;

  String get name { return _name; }

  User() {
    databaseName = 'common.db';
    tableName = 'user';
    tableExecute = '''
      id INTEGER PRIMARY KEY,
      name TEXT
    ''';
  }

  Future<void> sync() async {
    await open();
    final Map<String, dynamic> user = await get();
    _name = user['name'];
  }

  Future<Map<String, dynamic>> get() async {
    final List<Map<String, dynamic>> maps = await getRecode([userId]);

    if (maps.length <= 0) {
      final Map newUserMap = { 'name': 'Unknown' };
      await insertRecode(newUserMap);
      return newUserMap;
    }

    return maps[0];
  }

  Future<void> update(Map<String, dynamic> userData) async {
    await updateRecode(userId, userData);
  }
}
