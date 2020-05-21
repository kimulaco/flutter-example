import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class DatabaseProvider {
  String databaseName;
  String tableName;
  String tableExecute;
  Database db;

  DatabaseProvider({
    @required this.databaseName,
    @required this.tableName,
    @required this.tableExecute,
  });

  Future<void> open() async {
    final String dbPath = join(await getDatabasesPath(), databaseName);
    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database _db, version) {
        return _db.execute('CREATE TABLE $tableName($tableExecute)');
      },
    );
  }

  Future<void> delete() async {
    final String dbPath = join(await getDatabasesPath(), databaseName);
    await deleteDatabase(dbPath);
  }

  Future<void> insertRecode(Map<String, dynamic> recode) async {
    await db.insert(
      tableName,
      recode,
    );
  }

  Future<void> updateRecode(int id, Map<String, dynamic> recode) async {
    await db.update(
      tableName,
      recode,
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

  Future<List<Map<String, dynamic>>> getAllRecode() async {
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> getRecode(List<int> id) async {
    return await db.query(
      tableName,
      where: 'id IN (${id.join(', ')})',
    );
  }
}
