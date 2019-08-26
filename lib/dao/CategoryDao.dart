import 'dart:async';
import 'package:kmkshoppinglist/database/AbstractDataBase.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao extends AbstractDataBase {

  ///
  /// Singleton
  ///

  static CategoryDao _this;

  factory CategoryDao(){
    if(_this == null){
      _this = CategoryDao.getInstance();
    }
    return _this;
  }

  CategoryDao.getInstance() : super();

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
    return db.rawQuery('SELECT * FROM category ORDER BY categorys ASC');
  }

  @override
  Future<Map> getItem(dynamic where) async{
    Database db = await this.getDb();
    List<Map> categoryTable = await db.rawQuery('SELECT TOP 1* FROM category WHERE recid = $where LIMIT');

    Map result = Map();

    if(categoryTable.isNotEmpty){
      result = categoryTable.first;
    }

    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async{
    Database db = await this.getDb();
    int newRecId = await db.insert('category', values);

    return newRecId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async{
    Database db = await this.getDb();
    
    int rows = await db.update('category', values, where: 'recid = ?', whereArgs: [where]);

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic cat) async{
    Database db = await this.getDb();

    int rows = await db.delete('category', where: 'categorys = ?', whereArgs: [cat]);

    if((rows != 0)) {
      await db.delete('product', where: 'categorys = ?', whereArgs: [cat]);
    }

    return (rows != 0);
  }

  updateProductCount(dynamic category) async{
    Database db = await this.getDb();
    List<Map> list;
    int count = 0;

    list = await db.query('product', where: 'categorys = ?', whereArgs: [category]);

    if(list.isNotEmpty) {
      int rows = await await db.rawUpdate("""
                                          UPDATE  category SET qty_product = ? 
                                          WHERE categorys = ? """, [list.length,category]);

      if(rows > 0){}
    }
  }

  deleteProduct() {

  } 
}