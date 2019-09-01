import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kmkshoppinglist/dao/CategoryDao.dart';
import 'package:kmkshoppinglist/json-class/login/login-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/message-json/messages.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';

import 'package:kmkshoppinglist/json-class/category/category-model-json.dart';
import 'package:kmkshoppinglist/page/category/category.dart';

class CategoryJson {
  
  static post(BuildContext context, LoginModelJson loginData) async {
    
    CategoryDao dao = CategoryDao();

    List<CategoryJsonModel> categoryListData = List<CategoryJsonModel>();

    List<Map> categoryMap = await dao.list(0);
    Iterator iterator = categoryMap.iterator;

    while(iterator.moveNext()){
      Map map = iterator.current;

      CategoryJsonModel categoryData = CategoryJsonModel();

      categoryData.categorys = map['categorys'];
      categoryData.recid = map['recid'];

      categoryListData.add(categoryData);
    }

    final json = allPostsToJson(categoryListData);

    String temp = await LoginJson.getToken(loginData);
    
    final authKey = authorization(temp??"");

    dynamic response; 
    
    try {
      response = await http.post(url('Category', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
        body: json
      );
    } catch(Exception) {
      response = await http.post(url('Category', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
        body: json
      );
    }

    switch(response.statusCode) {
      case 200:
        code200(context, CategoryPage.tag);
        break;
      case 201:
        code201(context, CategoryPage.tag);
        break;
      case 400:
        code400(context, CategoryPage.tag);
        break;
      case 401:
        code401(context, CategoryPage.tag);
        break;
      case 402:
        code402(context, CategoryPage.tag);
        break;
      case 500:
        code500(context, CategoryPage.tag);
        break;
    }
  }

  static getAll(BuildContext context, LoginModelJson loginData, [int link = 1]) async {

    String temp = await LoginJson.getToken(loginData);
    
    final authKey = authorization(temp??"");

    dynamic response; 
    
    try {
      response = await http.get(url('Category', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        }
      );
    } catch(Exception) {
      response = await http.get(url('Category', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        }
      );
    }

    if(response.statusCode == 200)
    {
      CategoryDao dao = CategoryDao();

      List<CategoryJsonModel> listCategory = allPostsFromJson(response.body);

      Iterator iterator = listCategory.iterator;

      while(iterator.moveNext()) {
        CategoryJsonModel cat = iterator.current;

        Map mapCat = await dao.getItemSelect(cat.recid,cat.categorys);

        if(mapCat.isNotEmpty) {
          await dao.update({
            'recid': cat.recid,
            'id': cat.id,
            'categorys': cat.categorys,
            'createAt': cat.createAt,
            'updateAt': cat.updateAt
          }, mapCat['recid']);
        } else {
          await dao.insert({
            'recid': cat.recid,
            'id': cat.id,
            'categorys': cat.categorys,
            'createAt': cat.createAt,
            'updateAt': cat.updateAt
          });
        }
      }
    } 

    switch(response.statusCode) {
      case 200:
        code200(context, CategoryPage.tag);
        break;
      case 201:
        code201(context, CategoryPage.tag);
        break;
      case 400:
        code400(context, CategoryPage.tag);
        break;
      case 401:
        code401(context, CategoryPage.tag);
        break;
      case 402:
        code402(context, CategoryPage.tag);
        break;
      case 500:
        code500(context, CategoryPage.tag);
        break;
    }
  }
}