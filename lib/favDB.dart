import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'favModel.dart';

class FavDatabase {
  static final FavDatabase instance = FavDatabase.init();
  static Database? _database;

  FavDatabase.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('fav.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableFavorite (
    ${Favorite.id} $idType,
    ${Favorite.image} $textType,
    ${Favorite.name} $textType,
    ${Favorite.julukan} $textType,
    ${Favorite.since} $textType
    
    
    )''');
  }

  Future<FavoriteModel> create(FavoriteModel news) async {
    final db = await instance.database;

    final id = await db.insert(tableFavorite, news.toJson());
    return news.copy(id: id);
  }

  Future<bool> read(String? name) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorite,
      columns: Favorite.values,
      where: '${Favorite.name} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<FavoriteModel>> readAll() async {
    final db = await instance.database;

    final result = await db.query(tableFavorite);

    return result.map((json) => FavoriteModel.fromJson(json)).toList();
  }

  delete(String? name) async {
    final db = await instance.database;
    try {
      await db.delete(
        tableFavorite,
        where: '${Favorite.name} = ?',
        whereArgs: [name],
      );
    } catch (e) {
      print(e);
    }
  }

  update(FavoriteModel karyawanModel) async {
    final db = await instance.database;
    try {
      db.rawUpdate('''
    UPDATE ${tableFavorite} 
    SET ${Favorite.name} = ?, ${Favorite.image} = ?, ${Favorite.name} = ?, ${Favorite.julukan} = ?, ${Favorite.since} = ?, 
    WHERE ${Favorite.id} = ?
    ''', [
        karyawanModel.name,
        karyawanModel.image,
        karyawanModel.julukan,
        karyawanModel.since,
        karyawanModel.id
      ]);
    } catch (e) {
      print('error: ' + e.toString());
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
