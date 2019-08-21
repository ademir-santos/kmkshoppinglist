
import 'package:intl/intl.dart';

String dbName = 'kmkshopplist.db';
int dbVersion = 2;

List<String> dbCreate = [
  //TB CATEGORIA
  """
    CREATE TABLE category(
      recid INTEGER PRIMARY KEY,
      categorys TEXT
    )
  """,

  //TB PRODUTO
  """
    CREATE TABLE product(
      recid INTEGER PRIMARY KEY,
      products TEXT,
      brand TEXT,
      unit_measurement TEXT,
      refid_category INTEGER,
      categorys TEXT
    )
  """,

  """
    CREATE TABLE shopplist_category(
      recid INTEGER PRIMARY KEY,
      refid_shopplist INTEGER,
      list_name TEXT,
      refid_category INTEGER,      
      categorys TEXT,
      quantity_total INTEGER, 
      value_total DECIMAL(10,2),
      checked INTEGER DEFAULT 0,
      created TEXT    
    )
  """,

  """
    CREATE TABLE shopplist_category_temp(
      recid INTEGER PRIMARY KEY,
      refid_shopplist INTEGER,
      list_name TEXT,
      refid_category INTEGER,      
      categorys TEXT,
      quantity_total INTEGER, 
      value_total DECIMAL(10,2),
      checked INTEGER DEFAULT 0,
      created TEXT    
    )
  """,

  """
    CREATE TABLE shopplist_category_product(
      recid INTEGER PRIMARY KEY,
      refid_shopplist INTEGER,
      list_name TEXT,
      refid_category INTEGER,      
      categorys TEXT,
      refid_product INTEGER,
      products TEXT,
      quantity INTEGER,
      value_unitary DECIMAL(10,2), 
      quantity_total INTEGER, 
      value_total DECIMAL(10,2),
      created TEXT    
    )
  """,

  """
    CREATE TABLE table_price(
      recid INTEGER PRIMARY KEY,
      refid_category INTEGER,      
      categorys TEXT,
      refid_product INTEGER,
      products TEXT,
      price DECIMAL(10,2),
      created TEXT
    )
  """,

  //TB USUSARIO
  """
    CREATE TABLE user(
      recid INTEGER PRIMARY KEY,
      users TEXT,
      password TEXT,
      name TEXT
    )
  """,

  """
    CREATE TABLE user_shopplist(
      recid INTEGER PRIMARY KEY,
      refid_user INTEGER,
      list_name TEXT,
      value_total DECIMAL(10,2),
      created TEXT
    )
  """
];

double currencyToDouble(String value){
  value = value.replaceFirst('R\$ ', '');
  value = value.replaceAll(RegExp(r'\.'), '');
  value = value.replaceAll(RegExp(r'\,'), '.');

  return double.tryParse(value) ?? null;
}

double currencyToFloat(String value){
  return currencyToDouble(value);
}

String doubleToCurrency(double value){
  NumberFormat nf = NumberFormat.compactCurrency(locale: 'pt-BR', symbol: 'R\$');

  return nf.format(value ?? 0.00);
}

Map<String, int> unity = Map.from({ 'Un': 0, 'Kg': 3 });

