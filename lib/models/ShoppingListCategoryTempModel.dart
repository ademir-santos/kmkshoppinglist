import 'dart:async';
import 'package:kmkshoppinglist/database/AbstractDataBase.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingListCategoryTempModel extends AbstractDataBase {

  ///
  /// Singleton
  ///

  static ShoppingListCategoryTempModel _this;

  factory ShoppingListCategoryTempModel(){
    if(_this == null){
      _this = ShoppingListCategoryTempModel.getInstance();
    }
    return _this;
  }

  ShoppingListCategoryTempModel.getInstance() : super();

  ///
  /// the instance
  ///

  @override
  String get dbname => dbName;

  @override
  int get dbversion => dbVersion;

  @override
  Future<List<Map>> list(dynamic where) async{
    Database db = await this.getDb();
    return db.rawQuery('SELECT * FROM shopplist_category_temp ORDER BY list_name DESC');
  }

  @override
  Future<Map> getItem(dynamic where) async{
    Database db = await this.getDb();
    List<Map> categoryTable = await db.rawQuery('SELECT TOP 1* FROM shopplist_category_temp WHERE ? = $where LIMIT');

    Map result = Map();

    if(categoryTable.isNotEmpty){
      result = categoryTable.first;
    }

    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async{
    Database db = await this.getDb();
    int newRecId = await db.insert('shopplist_category_temp', values);

    return newRecId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async{
    Database db = await this.getDb();

    int rows = await db.update('shopplist_category_temp', values, where: 'recid = ?', whereArgs: [where]);

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic recId) async{
    Database db = await this.getDb();

    int rows = await db.delete('shopplist_category_temp', where: 'recid = ?', whereArgs: [recId]);

    return (rows != 0);
  }

  Future<bool> deleteAll() async{
    Database db = await this.getDb();

    int rows = await db.delete('shopplist_category_temp');

    return (rows != 0);
  }

  Future<bool> getItemExist(dynamic where) async{
    Database db = await this.getDb();

    List<Map> categoryTable = await db.rawQuery('SELECT TOP 1 recid FROM shopplist_category_temp WHERE categorys = $where LIMIT');

    if(categoryTable.isNotEmpty){
      return true; 
    }

    return false;
  }
}