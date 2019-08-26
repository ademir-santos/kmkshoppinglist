import 'dart:async';
import 'package:kmkshoppinglist/database/AbstractDataBase.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:sqflite/sqflite.dart';

class ShopplistCategoryProductTempDao extends AbstractDataBase {

  ///
  /// Singleton
  ///

  static ShopplistCategoryProductTempDao _this;

  factory ShopplistCategoryProductTempDao(){
    if(_this == null){
      _this = ShopplistCategoryProductTempDao.getInstance();
    }
    return _this;
  }

  ShopplistCategoryProductTempDao.getInstance() : super();

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
    return db.rawQuery('SELECT * FROM shopplist_category_product_temp WHERE categorys = $where ORDER BY products ASC');
  }

  @override
  Future<Map> getItem(dynamic where) async{
    Database db = await this.getDb();
    List<Map> categoryTable = await db.rawQuery('SELECT TOP 1* FROM shopplist_category_product_temp WHERE recid = $where LIMIT');

    Map result = Map();

    if(categoryTable.isNotEmpty){
      result = categoryTable.first;
    }

    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async{
    Database db = await this.getDb();
    int newRecId = await db.insert('shopplist_category_product_temp', values);

    return newRecId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async{
    Database db = await this.getDb();

    int rows = await db.update('shopplist_category_product_temp', values, where: 'recid = ?', whereArgs: [where]);

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic recId) async{
    Database db = await this.getDb();

    int rows = await db.delete('shopplist_category_product_temp', where: 'recid = ?', whereArgs: [recId]);

    return (rows != 0);
  }

  Future<List<Map>> loadList(dynamic refId, dynamic category) async{
    Database db = await this.getDb();

    List<Map> productsTable = await db.rawQuery("""
                                          SELECT * FROM shopplist_category_product_temp 
                                          WHERE refid_shopplist = ? 
                                          AND categorys = ?""", [refId,category]);

    return productsTable;
  }

  Future<bool> getItemExist(dynamic refId, dynamic category, dynamic product) async{
    Database db = await this.getDb();

    List<Map> productsTable = await db.rawQuery("""
                                          SELECT * FROM shopplist_category_product_temp 
                                          WHERE refid_shopplist = ? 
                                          AND categorys = ?
                                          AND products = ?""", [refId,category,product]);

    if(productsTable.isNotEmpty){
      return true; 
    }

    return false;
  }
}