import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kmkshoppinglist/dao/CategoryDao.dart';
import 'package:kmkshoppinglist/json-class/category/category-model-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/message-json/messages.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';

import '../variable-json.dart';



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

    //synchronizeCircularProgress(context, postFromJson(response.body), response.statusCode);
  }

  static getAll(BuildContext context, LoginModelJson loginData, [int link = 1]) async {

    dynamic temp;
    
    final authKey = authorization(temp??"");

    dynamic response; 
    /*
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        Future<String> temp = LoginJson.getToken(loginData);

        return AlertDialog(
          title: Text('Sincronizando dados'),
          
          content: new SingleChildScrollView(
            child: new Center(
              child: FutureBuilder<CategoryJsonModel>(
                future: ,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) { 

                    Navigator.of(ctx).pop(true);

                    switch(statusCode) {
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

                  } else if (snapshot.hasError) {
                    Navigator.of(ctx).pop(true);

                    switch(statusCode) {
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

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                }
              )
            )
          ),
        );
      }
    );*/

    

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

    //staticstatusCode = response.statusCode;  

    return postFromJson(response.body);
  }
}

Future<CategoryJsonModel> fetchPostCategory(LoginModelJson data) async {
  
  LoginModelJson loginJson = await fetchPostLogin(data); 
  
  final authKey = authorization(loginJson.acessToken??"");
  
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
  
  dynamic response;

  try {
      response = await http.post(url('Category', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
        body: json
      );
    } catch(Exeception){
      response = await http.post(url('Category', 2),
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
    return postCategoryFromJson(response.body);

  } else {
    // If that call was not successful, throw an error.
    return new CategoryJsonModel();
  }
}

Future<CategoryJsonModel> fetchGetCategory(LoginModelJson data) async {
  
  LoginModelJson loginJson = await fetchPostLogin(data); 
  
  final authKey = authorization(loginJson.acessToken??"");
   
  dynamic response;

  try {
      response = await http.get(url('Category', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
      );
    } catch(Exeception){
      response = await http.get(url('Category', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType(),
          HttpHeaders.authorizationHeader: authKey 
        },
      );
    }

  statusJson = response.statusCode;

  if(response.statusCode == 200) {
    
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

    return postCategoryFromJson(response.body);
  } 

  return new CategoryJsonModel();  
}