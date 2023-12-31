import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
