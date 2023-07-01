import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTablesUser(sql.Database database) async {
    const createTable = """CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      username TEXT,
      password TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""";

    await database.execute(createTable);
  }

  static Future<sql.Database> db_users() async {
    return sql.openDatabase('habibfr.users', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("..crete a table...");
      await createTablesUser(database);
    });
  }

  static Future<int> createUser(String username, String password) async {
    final db = await SQLHelper.db_users();
    final data = {'username': username, 'password': password};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelper.db_users();

    return db.query('users', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await SQLHelper.db_users();

    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> login(
      String username, String password) async {
    final db = await SQLHelper.db_users();

    final result = db.query("users",
        where: "username= ?, password = ?",
        whereArgs: [username, password],
        limit: 1);

    return result;
  }

  static Future<int> updateUser(
      int id, String username, String? password) async {
    final db = await SQLHelper.db_users();

    final data = {
      'username': username,
      'password': password,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db_users();

    try {
      await db.delete('items', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint('Error to delete : $e');
    }
  }
}
