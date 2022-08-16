import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radio/shared/network/local/favourite_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static final LocalDB instance = LocalDB._init();

  LocalDB._init();

  static Database? _database;

  static const _dbName = 'radio.db';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final dbPath = '$appDocPath/$dbName';

    debugPrint('----- database created successfully at: $dbPath -----');

    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    // const textTypeNull = 'TEXT';

    await db.execute('''
    CREATE TABLE $tableFavourite (
    ${LocalFavouriteModelFields.itemId} INTEGER PRIMARY KEY,
    ${LocalFavouriteModelFields.name} $textType,
    ${LocalFavouriteModelFields.type} $textType,
    ${LocalFavouriteModelFields.imageUrl} $textType,
    ${LocalFavouriteModelFields.soundUrl} $textType,
    ${LocalFavouriteModelFields.isFav} $textType
    )
    ''');
  }

  /// working with [saveItemData] ////////////////////////////////////
  Future<void> saveItemData({
    required FavouriteModel favouriteModel,
  }) async {
    final db = await instance.database;

    await db.insert(
      tableFavourite,
      favouriteModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FavouriteModel>> getItemsData() async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(
      tableFavourite,
      columns: LocalFavouriteModelFields.values,
    );

    if (maps.isNotEmpty) {
      List<FavouriteModel> items =
          maps.map((element) => FavouriteModel.fromJson(element)).toList();

      debugPrint(
          '----- maps values ${maps.map((e) => e.values).toString()} -----');
      debugPrint('----- items length ${items.length.toString()} ------');

      return items;
    } else {
      log('dataBase is empty');
      return [];
    }
  }

  Future<FavouriteModel?> getSingleItemData({required int itemId}) async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(
      tableFavourite,
      columns: LocalFavouriteModelFields.values,
      where: '${LocalFavouriteModelFields.itemId} = ?',
      whereArgs: [itemId],
    );

    if (maps.isNotEmpty) {
      return FavouriteModel.fromJson(maps.first);
    }

    return null;
  }

  Future<int> updateItemData({required FavouriteModel favouriteModel}) async {
    final db = await instance.database;
    return await db.update(
      tableFavourite,
      favouriteModel.toJson(),
      where: '${LocalFavouriteModelFields.itemId} = ?',
      whereArgs: [favouriteModel.id],
    );
  }

  Future<int> deleteItemData({required FavouriteModel favouriteModel}) async {
    final db = await instance.database;

    return await db.delete(
      tableFavourite,
      where: '${LocalFavouriteModelFields.itemId} = ?',
      whereArgs: [favouriteModel.id],
    );
    // return await db.rawDelete(
    //   'DELETE FROM $tableFavourite WHERE ${LocalFavouriteModelFields.itemId} = ?',
    //   [favouriteModel.id],
    // );
  }

  /// working with [closeDB] //////////////////////////////////////
  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }

  Future deleteDB(String tableName) async {
    final db = await instance.database;
    db.delete(tableName);
  }

}
