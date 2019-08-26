import 'dart:async';
import 'package:kmkshoppinglist/database/AbstractDataBase.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:sqflite/sqflite.dart';

class UserShoppingListDao extends AbstractDataBase {

  ///
  /// Singleton
  ///

  static UserShoppingListDao _this;

  factory UserShoppingListDao(){
    if(_this == null){
      _this = UserShoppingListDao.getInstance();
    }
    return _this;
  }

  UserShoppingListDao.getInstance() : super();

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
    return db.rawQuery('SELECT * FROM user_shopplist WHERE refid_user = $where ORDER BY list_name DESC');
  }

  @override
  Future<Map> getItem(dynamic where) async{
    Database db = await this.getDb();
    List<Map> categoryTable = await db.rawQuery('SELECT TOP 1* FROM user_shopplist WHERE recid = $where LIMIT');

    Map result = Map();

    if(categoryTable.isNotEmpty){
      result = categoryTable.first;
    }

    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async{
    Database db = await this.getDb();
    int newRecId = await db.insert('user_shopplist', values);

    return newRecId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async{
    Database db = await this.getDb();

    int rows = await db.update('user_shopplist', values, where: 'recid = ?', whereArgs: [where]);

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic recId) async{
    Database db = await this.getDb();

    int rows = await db.delete('user_shopplist', where: 'recid = ?', whereArgs: [recId]);

    return (rows != 0);
  }

  Future<Map> getItemSelect(dynamic recId, [dynamic vl = 0.00]) async{
    Database db = await this.getDb();
    List<Map> table;
    
    if(vl > 0) {
      table = await db.rawQuery("""
                                  SELECT * FROM user_shopplist 
                                  WHERE recid = ?
                                  AND value_total = ? """, [recId,vl]);
    } else {
      table = await db.rawQuery("""
                                  SELECT * FROM user_shopplist 
                                  WHERE recid = ? """, [recId]);
    }

    Map result = Map();

    if(table.isNotEmpty){
      result = table.first;
    }

    return result;
  }

  Future<bool> updateSelect(dynamic recId, [dynamic vl = 0.00]) async{
    Database db = await this.getDb();
    int rows = 0;
    
    Map map = await getItemSelect(recId, vl);

    if(map.isNotEmpty){
      int recId = map['recid'];
      
      if(vl > 0){
        rows = await db.rawUpdate("""
                                    UPDATE user_shopplist 
                                    SET value_total = ?
                                    WHERE recid = ? """, [vl,recId]);
      } 
    }

    return (rows != 0);
  }
}