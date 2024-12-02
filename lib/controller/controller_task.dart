import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseControllerTask {
  static final DatabaseControllerTask _instance =
      DatabaseControllerTask._internal();

  factory DatabaseControllerTask() => _instance;

  DatabaseControllerTask._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        date TEXT,
        completed INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<int> createTask(
    String title,
    String? description,
    String? date,
  ) async {
    final db = await database;
    return await db.insert(
      'tasks',
      {
        'title': title,
        'description': description,
        'date': date,
        'completed': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tasks', orderBy: 'id DESC');
  }

  Future<void> updateTask({
    required int id,
    String? title,
    String? description,
    String? date,
    int? completed,
  }) async {
    try {
      final db = await database;

      // Cria um mapa apenas com os campos não nulos
      final Map<String, dynamic> valuesToUpdate = {};
      if (title != null) valuesToUpdate['title'] = title;
      if (description != null) valuesToUpdate['description'] = description;
      if (date != null) valuesToUpdate['date'] = date;
      if (completed != null) valuesToUpdate['completed'] = completed;

      if (valuesToUpdate.isNotEmpty) {
        await db.update(
          'tasks',
          valuesToUpdate,
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        print('Nenhum campo para atualizar');
      }
    } catch (e) {
      print('Erro ao atualizar a tarefa: $e');
    }
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
