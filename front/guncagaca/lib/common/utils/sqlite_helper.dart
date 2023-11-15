import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../store/models/store_ip.dart';

class SQLiteHelper {
  static final SQLiteHelper instance = SQLiteHelper._init();
  static Database? _database;

  SQLiteHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('storeIp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE storeIp(
      storeId INTEGER PRIMARY KEY,
      ownerId INTEGER,
      ip TEXT,
      port TEXT
    )
    ''');
  }

  Future<void> insertOrUpdateStore(StoreIp storeIp) async {
    final db = await SQLiteHelper.instance.database;
    await db.insert(
      'storeIp',
      storeIp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // 중복 시 업데이트
    );
  }

  Future<List<StoreIp>> fetchStores() async {
    final db = await instance.database;
    final result = await db.query('storeIp');

    return result.map((json) => StoreIp.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
