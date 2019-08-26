import 'dart:async';
import 'package:kmkshoppinglist/database/AbstractDataBase.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:sqflite/sqflite.dart';

class LoginDao extends AbstractDataBase {
  static LoginDao _this;

  factory LoginDao(){
    if(_this == null){
      _this = LoginDao.getInstance();
    }
    return _this;
  }

  LoginDao.getInstance() : super();

  ///
  /// the instance
  ///

  @override
  String get dbname => dbName;

  @override
  int get dbversion => dbVersion;

  Future<Map> login(String login, String password, [dynamic active = 1]) async{
    Database db = await this.getDb();
    Map user = Map();

    List<Map> userTable = await db.rawQuery("""
                                              SELECT * FROM user 
                                              WHERE users = ? 
                                              AND password = ?
                                              AND active = ?""", [login,password,active]);                                     

    if(userTable.isNotEmpty) {
      user = userTable.first;
    }

    return user;
  }

  @override
  Future<List<Map>> list(dynamic where) async{
    Database db = await this.getDb();
    return db.rawQuery('SELECT * FROM user ORDER BY users ASC');
  }

  @override
  Future<Map> getItem(dynamic where) async{
    Database db = await this.getDb();
    List<Map> categoryTable = await db.rawQuery('SELECT TOP 1* FROM user WHERE recid = $where LIMIT');

    Map result = Map();

    if(categoryTable.isNotEmpty){
      result = categoryTable.first;
    }

    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async{
    Database db = await this.getDb();
    int newRecId = await db.insert('user', values);

    return newRecId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async{
    Database db = await this.getDb();

    int rows = await db.update('user', values, where: 'recid = ?', whereArgs: [where]);

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic recId) async{
    Database db = await this.getDb();

    int rows = await db.delete('user', where: 'recid = ?', whereArgs: [recId]);

    return (rows != 0);
  }
}