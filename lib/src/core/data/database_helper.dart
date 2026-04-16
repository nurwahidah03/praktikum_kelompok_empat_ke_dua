import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/quota_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('usage_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, 
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }
  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE history (
      date TEXT PRIMARY KEY, 
      wifi INTEGER, 
      mobile INTEGER
    )
    ''');
    await db.execute('''
    CREATE TABLE quota (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      maxQuota INTEGER,
      usedQuota INTEGER
    )
    ''');
  }
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE quota (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        maxQuota INTEGER,
        usedQuota INTEGER
      )
      ''');
    }
  }
  Future<void> insertOrUpdate(String date, int wifi, int mobile) async {
    final db = await database;

    await db.insert(
      'history',
      {'date': date, 'wifi': wifi, 'mobile': mobile},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('history', orderBy: 'date DESC');
  }
  Future<List<QuotaModel>> getQuota() async {
    final db = await database;
    final result = await db.query('quota');

    return result.map((e) => QuotaModel.fromMap(e)).toList();
  }

  Future<int> insertQuota(QuotaModel quota) async {
    final db = await database;
    return await db.insert('quota', quota.toMap());
  }
  Future<int> updateQuota(QuotaModel quota) async {
    final db = await database;
    return await db.update(
      'quota',
      quota.toMap(),
      where: 'id = ?',
      whereArgs: [quota.id],
    );
  }
  Future<int> resetQuota(int id) async {
    final db = await database;
    return await db.update(
      'quota',
      {'usedQuota': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}