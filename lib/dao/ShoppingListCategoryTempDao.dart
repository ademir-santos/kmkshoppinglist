import 'dart:async';
import 'package:kmkshoppinglist/database/AbstractDataBase.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingListCategoryTempDao extends AbstractDataBase {

  ///
  /// Singleton
  ///

  static ShoppingListCategoryTempDao _this;

  factory ShoppingListCategoryTempDao(){
    if(_this == null){
      _this = ShoppingListCategoryTempDao.getInstance();
    }
    return _this;
  }

  ShoppingListCategoryTempDao.getInstance() : super();

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

    return db.query('shopplist_category_temp', where: 'refid_shopplist = ?', whereArgs: [where]);
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
    int rows = 0;

    rows = await db.update('shopplist_category_temp', values, where: 'recid = ?', whereArgs: [where]);
    
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

  Future<int> getRecIdCategory(dynamic refId, dynamic category) async{
    Database db = await this.getDb();
    int recId = 0;

    List<Map> categoryTable = await db.rawQuery("""
                                              SELECT * FROM shopplist_category_temp 
                                              WHERE refid_shopplist = ? 
                                              AND categorys = ?""", [refId,category]);

    if(categoryTable.isNotEmpty){
      categoryTable.forEach((map){
        recId = map['recid'];
      }); 
    }

    return recId;
  }

  Future<bool> getItemExist(dynamic refId, dynamic category) async{
    Database db = await this.getDb();

    List<Map> categoryTable = await db.rawQuery("""
                                          SELECT * FROM shopplist_category_temp 
                                          WHERE refid_shopplist = ? 
                                          AND categorys = ?""", [refId,category]);

    if(categoryTable.isNotEmpty){
      return true; 
    }

    return false;
  }

  Future<List<Map>> listTemp(int refIdList) async{
    Database db = await this.getDb();

    return await db.rawQuery('SELECT * FROM shopplist_category_temp WHERE refid_shopplist = $refIdList');
  }

  Future<bool> updateSelectedCategory(dynamic refId, dynamic category, int checked) async{
    Database db = await this.getDb();
    int rows = 0;
    int recid = 0;

    List<Map> categoryTable = await db.rawQuery("""
                                                  SELECT recid FROM shopplist_category_temp 
                                                  WHERE refid_shopplist = ? 
                                                  AND categorys = ?""", [refId,category]);
    if(categoryTable.isNotEmpty){
      categoryTable.forEach((map){
        recid = map['recid'];
      });

      rows = await db.rawUpdate("""UPDATE shopplist_category_temp SET checked = ? WHERE recid = ?""", [checked,recid]);
    }

    return (rows != 0);
  }
}