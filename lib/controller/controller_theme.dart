import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ControllerTheme {
  static final ControllerTheme _instance = ControllerTheme._internal();

  factory ControllerTheme() => _instance;

  ControllerTheme._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'theme_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE theme (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isDarkMode INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Insere o estado inicial como "Modo Claro" (isDarkMode = 0)
    await db.insert('theme', {'isDarkMode': 0});
  }

  Future<bool> isDarkMode() async {
    final db = await database;
    final result = await db.query('theme', where: 'id = ?', whereArgs: [1]);

    if (result.isNotEmpty) {
      return result.first['isDarkMode'] == 1;
    }
    return false; // Retorna falso se não encontrar o registro
  }

  Future<void> toggleDarkMode(bool enable) async {
    final db = await database;
    await db.update(
      'theme',
      {'isDarkMode': enable ? 1 : 0},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
