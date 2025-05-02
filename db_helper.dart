// lib/services/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';


class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        dueDate TEXT,
        startHour INTEGER,
        startMinute INTEGER,
        endHour INTEGER,
        endMinute INTEGER,
        isCompleted INTEGER,
        status TEXT
      )
    ''');
  }

  Future<void> insertTask(Task t) async {
    final db = await database;
    await db.insert(
      'tasks',
      t.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> fetchTasks() async {
    final db = await database;
    final maps = await db.query('tasks');
    // Use Task.fromMap for each row
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<void> updateTask(Task t) async {
    final db = await database;
    await db.update(
      'tasks',
      t.toMap(),
      where: 'id = ?',
      whereArgs: [t.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

