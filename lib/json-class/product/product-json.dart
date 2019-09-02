import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kmkshoppinglist/dao/ProductDao.dart';
import 'package:kmkshoppinglist/json-class/login/login-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/message-json/messages.dart';
import 'package:kmkshoppinglist/json-class/product/product-model-json.dart';
import 'package:kmkshoppinglist/page/product/product.dart';

import '../variable-json.dart';

class ProductJson { 

  static post(BuildContext context, LoginModelJson loginData, categorys) async {
    
    ProductDao dao = ProductDao();

    List<ProductModelJson> productListData = List<ProductModelJson>();

    List<Map> productMap = await dao.list(categorys);
    Iterator iterator = productMap.iterator;

    while(iterator.moveNext()){
      Map map = iterator.current;

      ProductModelJson productData = ProductModelJson();

      productData.products = map['products'];
      productData.brand = map['brand'];
      productData.unit_measurement = map['unit_measurement'];
      productData.refid_category = map['refid_category'];
      productData.categorys = map['categorys'];
      productData.recid = map['recid'];
      productData.createAt = map['createAt'];
      productData.updateAt = map['updateAt'];

      productListData.add(productData);
    }

    final json = allPostsToJson(productListData);

    String temp = await LoginJson.getToken(loginData);
    
    final authKey = authorization(temp??"");

    dynamic response; 
    
    try {
      response = await http.post(url('Product', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
        body: json
      );
    } catch(Exception) {
      response = await http.post(url('Product', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
        body: json
      );
    }

    switch(response.statusCode) {
      case 200:
        code200(context, ProductPage.tag);
        break;
      case 201:
        code201(context, ProductPage.tag);
        break;
      case 400:
        code400(context, ProductPage.tag);
        break;
      case 401:
        code401(context, ProductPage.tag);
        break;
      case 402:
        code402(context, ProductPage.tag);
        break;
      case 500:
        code500(context, ProductPage.tag);
        break;
    }
  }

  static getAll(BuildContext context, LoginModelJson loginData) async {

    String temp = await LoginJson.getToken(loginData);
    
    final authKey = authorization(temp??"");

    dynamic response; 
    
    try {
      response = await http.get(url('Product', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        }
      );
    } catch(Exception) {
      response = await http.get(url('Product', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        }
      );
    }

    if(response.statusCode == 200)
    {
      ProductDao dao = ProductDao();

      List<ProductModelJson> listProduct = allPostsFromJson(response.body);

      Iterator iterator = listProduct.iterator;

      while(iterator.moveNext()) {
        ProductModelJson prod = iterator.current;

        Map mapProd = await dao.getItemSelect(prod.recid,prod.categorys,prod.products);

        if(mapProd.isNotEmpty) {
          await dao.update({
            'products': prod.products,
            'brand': prod.brand,
            'unit_measurement': prod.unit_measurement,
            'refid_category': prod.refid_category,
            'categorys': prod.categorys,
            'id': prod.id,
            'recid': prod.recid,
            'createAt': prod.createAt,
            if((prod.updateAt != null) || (prod.updateAt == ''))
              'updateAt': prod.updateAt
          },mapProd['recid']);
        } else {
          await dao.insert({
            'products': prod.products,
            'brand': prod.brand,
            'unit_measurement': prod.unit_measurement,
            'refid_category': prod.refid_category,
            'categorys': prod.categorys,
            'id': prod.id,
            'recid': prod.recid,
            'createAt': prod.createAt,
            if((prod.updateAt != null) || (prod.updateAt == ''))
              'updateAt': prod.updateAt
          });
        }
      }
    } 

    switch(response.statusCode) {
      case 200:
        code200(context, ProductPage.tag);
        break;
      case 201:
        code201(context, ProductPage.tag);
        break;
      case 400:
        code400(context, ProductPage.tag);
        break;
      case 401:
        code401(context, ProductPage.tag);
        break;
      case 402:
        code402(context, ProductPage.tag);
        break;
      case 500:
        code500(context, ProductPage.tag);
        break;
    }
  }
}

Future<ProductModelJson> fetchPostProduct(LoginModelJson data) async {
  
  LoginModelJson loginJson = await fetchPostLogin(data); 
  
  final authKey = authorization(loginJson.acessToken??"");
  
  ProductDao dao = ProductDao();

  List<ProductModelJson> productListData = List<ProductModelJson>();

  List<Map> productMap = await dao.list(0);
  
  Iterator iterator = productMap.iterator;

  while(iterator.moveNext()){
    Map map = iterator.current;

    ProductModelJson productData = ProductModelJson();

    productData.products = map['products'];
    productData.brand = map['brand'];
    productData.unit_measurement = map['unit_measurement'];
    productData.refid_category = map['refid_category'];
    productData.categorys = map['categorys'];
    productData.recid = map['recid'];
    productData.createAt = map['createAt'];
    productData.updateAt = map['updateAt'];

    productListData.add(productData);
  }

  final json = allPostsToJson(productListData);
  
  dynamic response;

  try {
      response = await http.post(url('Product', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
        body: json
      );
    } catch(Exeception){
      response = await http.post(url('Product', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
        body: json
      );
    }

  statusJson = response.statusCode;

  if (response.statusCode == 200 || response.statusCode == 201) {
    //If the call to the server was successful, parse the JSON.
    return postProductFromJson(response.body);

  } else {
    // If that call was not successful, throw an error.
    return new ProductModelJson();
  }
}

Future<ProductModelJson> fetchGetProduct(LoginModelJson data) async {
  
  LoginModelJson loginJson = await fetchPostLogin(data); 
  
  final authKey = authorization(loginJson.acessToken??"");
   
  dynamic response;

  try {
      response = await http.get(url('Product', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
      );
    } catch(Exeception){
      response = await http.get(url('Product', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
      );
    }

  statusJson = response.statusCode;

  if(response.statusCode == 200) {
    
    ProductDao dao = ProductDao();

    List<ProductModelJson> listCategory = allPostsFromJson(response.body);

    Iterator iterator = listCategory.iterator;

    while(iterator.moveNext()) {
      ProductModelJson prod = iterator.current;

      Map mapProd = await dao.getItemSelect(prod.recid,prod.categorys,prod.products);

      if(mapProd.isNotEmpty) {
          await dao.update({
            'products': prod.products,
            'brand': prod.brand,
            'unit_measurement': prod.unit_measurement,
            'refid_category': prod.refid_category,
            'categorys': prod.categorys,
            'id': prod.id,
            'recid': prod.recid,
            'createAt': prod.createAt,
            if((prod.updateAt != null) || (prod.updateAt == ''))
              'updateAt': prod.updateAt
          },mapProd['recid']);
        } else {
          await dao.insert({
            'products': prod.products,
            'brand': prod.brand,
            'unit_measurement': prod.unit_measurement,
            'refid_category': prod.refid_category,
            'categorys': prod.categorys,
            'id': prod.id,
            'recid': prod.recid,
            'createAt': prod.createAt,
            if((prod.updateAt != null) || (prod.updateAt == ''))
              'updateAt': prod.updateAt
          });
        }
    }

    return postProductFromJson(response.body);
  } 

  return new ProductModelJson();  
}