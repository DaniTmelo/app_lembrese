import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class ControllerUser {
  static final ControllerUser _instance = ControllerUser._internal();

  factory ControllerUser() => _instance;

  ControllerUser._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'users_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<int> createUser(String name, String email, String password) async {
    final db = await database;

    try {
      final hashedPassword = _hashPassword(password);
      return await db.insert(
        'users',
        {
          'name': name,
          'email': email,
          'password': hashedPassword,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Erro ao criar usuário: $e');
      throw Exception('Não foi possível criar o usuário');
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<bool> authenticateUser(String email, String password) async {
    final user = await getUserByEmail(email);

    if (user != null) {
      final hashedPassword = _hashPassword(password);
      return user['password'] == hashedPassword;
    }
    return false;
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateUser({
    required int id,
    String? name,
    String? email,
    String? password,
  }) async {
    final db = await database;

    final Map<String, dynamic> valuesToUpdate = {};
    if (name != null) valuesToUpdate['name'] = name;
    if (email != null) valuesToUpdate['email'] = email;
    if (password != null) {
      valuesToUpdate['password'] = _hashPassword(password);
    }

    return await db.update(
      'users',
      valuesToUpdate,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
