import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_flutter_app/database/models/city.dart';

class DatabaseProvider extends ChangeNotifier {
  static DatabaseProvider? _instance;
  static Database? _database;
  final int version = 1;

  DatabaseProvider._privateConstructor();

  static DatabaseProvider get instance {
    _instance ??= DatabaseProvider._privateConstructor();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'cities_database.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE city (
            id INTEGER PRIMARY KEY,
            name TEXT,
            imagePath TEXT
          )
          ''');
      },
      version: version,
    );
  }

  Future<int> insertCity(Map<String, dynamic> city) async {
    final db = await database;
    return db.insert('city', city);
  }

  Future<int> deleteCity(String cityName) async {
    final db = await database;
    return await db.delete(
      'city',
      where: 'name = ?',
      whereArgs: [cityName],
    );
  }

  Future<bool> checkCityExists(String cityName) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'city',
      where: 'name = ?',
      whereArgs: [cityName],
    );

    return result.isNotEmpty;
  }

  Future<List<City>> getCities() async {
    final db = await database;
    List<Map<String, dynamic>> records = await db.query('city');
    List<City> cities = [];
    for (var record in records) {
      City city = City.fromMap(record);
      cities.add(city);
    }
    return cities;
  }
}
