import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  final String tableName = 'cities';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'cities_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, name TEXT, imagePath TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertCity(Map<String, dynamic> city) async {
    final db = await database;
    return db.insert(tableName, city);
  }

  Future<List<Map<String, dynamic>>> getCities() async {
    final db = await database;
    return db.query(tableName);
  }
}
