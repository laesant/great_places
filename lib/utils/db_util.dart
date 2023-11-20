import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
