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
    
    rows = await db.update('shopplist_category', values, where: 'categorys = ?', whereArgs: [where]);

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

  Future<Map> getItemSelect(dynamic refId, dynamic category) async{
    Database db = await this.getDb();
    List<Map> categoryTable;
    
    categoryTable = await db.rawQuery("""
                                        SELECT * FROM shopplist_category 
                                        WHERE refid_shopplist = ? 
                                        AND categorys = ?""", [refId,category]);

    Map result = Map();

    if(categoryTable.isNotEmpty){
      result = categoryTable.first;
    }

    return result;
  }

  Future<bool> modifQtySelect(dynamic refId, dynamic category, dynamic qty) async{
    Database db = await this.getDb();
    List<Map> categoryTable;
    
    categoryTable = await db.rawQuery("""
                                        SELECT * FROM shopplist_category 
                                        WHERE refid_shopplist = ? 
                                        AND categorys = ?
                                        AND quantity_total = ?""", [refId,category,qty]);

    bool result = false;

    if(categoryTable.isNotEmpty){
      result = true;
    }

    return result;
  }

  Future<bool> modifVlSelect(dynamic refId, dynamic category, dynamic vl) async{
    Database db = await this.getDb();
    List<Map> categoryTable;
    
    categoryTable = await db.rawQuery("""
                                        SELECT * FROM shopplist_category 
                                        WHERE refid_shopplist = ? 
                                        AND categorys = ?
                                        AND value_total = ?""", [refId,category,vl]);

    bool result = false;

    if(categoryTable.isNotEmpty){
      result = true;
    }

    return result;
  }

  Future<bool> updateSelect(dynamic refId, dynamic category, [dynamic vl = 0.00, dynamic qt = 0]) async{
    Database db = await this.getDb();
    int rows = 0;
    
    Map map = await getItemSelect(refId, category);

    if(map.isNotEmpty){
      int recId = map['recid'];
      if(vl > 0){
        rows = await db.rawUpdate("""
                                    UPDATE shopplist_category 
                                    SET value_total = ?
                                    WHERE recid = ? """, [vl,recId]);
      } 
      
      if(qt > 0) {
        rows = await db.rawUpdate("""
                                    UPDATE shopplist_category 
                                    SET quantity_total = ?
                                    WHERE recid = ? """, [qt,recId]);
      }
    }

    return (rows != 0);
  }

  deleteAllForCategory(dynamic refId, dynamic category) async{
    Database db = await this.getDb();
    int rows = 0;
    int rowsProd = 0;
    int recId = 0;
    List<Map> tableTempProd = new List<Map>();
    List<Map> tableTempCat = new List<Map>();

    Map table = await getItemSelect(refId, category);

    if(table.isNotEmpty){

      recId = table['recid'];

      rows = await db.delete('shopplist_category', where: 'recid = ?', whereArgs: [recId]);

      rowsProd = await db.delete('shopplist_category_product', where: 'refid_category = ?', whereArgs: [recId]);

      if(rows != 0) {


        tableTempProd = await db.rawQuery("""
                                        SELECT * FROM shopplist_category_product_temp 
                                        WHERE refid_shopplist = ? 
                                        AND categorys = ?""", [refId,category]);                              

        if(tableTempProd.isNotEmpty) {
          Iterator interatorProd = tableTempProd.iterator;

          while(interatorProd.moveNext()) {
            Map map = interatorProd.current;
            int recIdList = map['recid'];

            updateTempProd({ 'checked': 0 }, recIdList);
          }
        }

        tableTempCat = await db.rawQuery("""
                                        SELECT * FROM shopplist_category_temp 
                                        WHERE refid_shopplist = ? 
                                        AND categorys = ?""", [refId,category]);          

        if(tableTempCat.isNotEmpty) {
          Iterator interatorCat = tableTempCat.iterator;

          while(interatorCat.moveNext()) {
            Map map = interatorCat.current;

            int recIdList = map['recid'];

            updateTempCat({ 'checked': 0 }, recIdList);
          }
        }
      }
    }                            

    return (rows != 0);
  }

  Future<bool> updateTempCat(Map<String, dynamic> valuesCat, dynamic recIdTempCat) async{
    Database db = await this.getDb();
    int rows = 0;

    rows = await db.update('shopplist_category_temp', valuesCat, where: 'recid = ?', whereArgs: [recIdTempCat]);
    
    return (rows != 0);
  }

  Future<bool> updateTempProd(Map<String, dynamic> valuesProd, dynamic recIdTempProd) async{
    Database db = await this.getDb();
    int rows = 0;

    rows = await db.update('shopplist_category_product_temp', valuesProd, where: 'recid = ?', whereArgs: [recIdTempProd]);
    
    return (rows != 0);
  }
}