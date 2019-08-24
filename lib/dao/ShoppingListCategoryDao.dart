import 'dart:async';
import 'package:kmkshoppinglist/database/AbstractDataBase.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingListCategoryDao extends AbstractDataBase {

  ///
  /// Singleton
  ///

  static ShoppingListCategoryDao _this;

  factory ShoppingListCategoryDao(){
    if(_this == null){
      _this = ShoppingListCategoryDao.getInstance();
    }
    return _this;
  }

  ShoppingListCategoryDao.getInstance() : super();

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
    
    return db.query('shopplist_category', where: 'refid_shopplist = ?', whereArgs: [where]);
  }

  @override
  Future<Map> getItem(dynamic where) async{
    Database db = await this.getDb();
    List<Map> categoryTable;
    //List<Map> categoryTable = await db.rawQuery('SELECT TOP 1* FROM shopplist_category WHERE recid = $where LIMIT');

    Map result = Map();

    if(categoryTable.isNotEmpty){
      result = categoryTable.first;
    }

    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async{
    Database db = await this.getDb();

    int newRecId = await db.insert('shopplist_category', values);

    return newRecId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async{
    Database db = await this.getDb();
    int rows = 0;
    bool exists = false;
    
    //exists = await getItemExist(values['categorys'].toString());
    
    if(exists){
      rows = await db.update('shopplist_category', values, where: 'recid = ?', whereArgs: [where]);
    }

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic recId) async{
    Database db = await this.getDb();

    int rows = await db.delete('shopplist_category', where: 'recid = ?', whereArgs: [recId]);

    return (rows != 0);
  }

    Future<bool> getItemExist(dynamic refId, dynamic category) async{
    Database db = await this.getDb();

    /*List<Map> categoryTable = await db.rawQuery("""
                                              SELECT * FROM shopplist_category 
                                              WHERE refid_shopplist = ${refId} 
                                              AND categorys = ${category}""");*/
    List<Map> categoryTable = await db.rawQuery("""
                                          SELECT * FROM shopplist_category 
                                          WHERE refid_shopplist = ? 
                                          AND categorys = ?""", [refId,category]);

    if(categoryTable.isNotEmpty){
      return true; 
    }

    return false;
  }

  Future<int> getRecIdCategory(dynamic refId, dynamic category) async{
    Database db = await this.getDb();
    int recId = 0;

    //List<Map> results = await db.query("shopplist_category", where: 'refid_shopplist = ?', whereArgs: [refId], and: 'categorys = ?' andArgs: [category]);

    List<Map> categoryTable = await db.rawQuery("""
                                              SELECT * FROM shopplist_category 
                                              WHERE refid_shopplist = ? 
                                              AND categorys = ?""", [refId,category]);

    if(categoryTable.isNotEmpty){
      categoryTable.forEach((map){
        recId = map['recid'];
      }); 
    }

    return recId;
  }

  Future<bool> updateTemp(Map<String, dynamic> values, where) async{
    Database db = await this.getDb();
    int rows = 0;

    //bool exists = await getItemExist(values['categorys'].toString());
    /*
    if(exists){
      rows = await db.update('shopplist_category_temp', values, where: 'recid = ?', whereArgs: [where]);
    }*/
    
    return (rows != 0);
  }
}