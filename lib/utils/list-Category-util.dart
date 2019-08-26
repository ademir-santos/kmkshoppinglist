import 'dart:async';

import 'package:kmkshoppinglist/dao/ShoppingListCategoryDao.dart';
import 'package:kmkshoppinglist/dao/ShoppingListCategoryTempDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

setcategoryList(int refIdShoppList, String listName, Map category){

  ShoppingListCategoryDao shoppingListCategoryDao = ShoppingListCategoryDao();

  return shoppingListCategoryDao.insert({
    'refid_shopplist': refIdShoppList,
    'list_name': listName,
    'refid_category': category['recid'],
    'category': category['categorys'],
    'checked': 1,
    'created': DateTime.now().toString()
  }).then((recId){
    //Navigator.of(ctx).pop();
    //Navigator.of(ctx).popAndPushNamed(ListMirrorCategory.tag);
  });    
}

loadCategoryListTemp(Stream<List<Map>> futureList) async{
  ShoppingListCategoryTempDao shoppingListCategoryTempDao = ShoppingListCategoryTempDao();
  bool exists = false;

  await for(var mapList in futureList){
    if(mapList.isNotEmpty){
      for(var map in mapList){
        String category = map['categorys'].toString();
        int refId = HomePage.refId;

        if(category.isNotEmpty){
          exists = await shoppingListCategoryTempDao.getItemExist(refId, category);

          if(!exists){
            shoppingListCategoryTempDao.insert({
              'refid_shopplist': HomePage.refId,
              'list_name': HomePage.listName,
              'refid_category': map['recid'],
              'categorys': map['categorys'],
              'checked': 0,
              'quantity_total': 0,
              'value_total': 0.00
            });
          }
        }
      }
    }
    else{
      return;
    }
  }
}

loadCategoryList(Stream<List<Map>> futureList) async{
  ShoppingListCategoryDao shoppingListCategoryDao = ShoppingListCategoryDao();
  bool exists = false;

  await for(var mapList in futureList){

    if(mapList.isNotEmpty){
      for(var map in mapList){
        String category = map['categorys'].toString();
        int checked = map['checked'];
        int refId = map['refid_shopplist'];

        if(category.isNotEmpty){
          exists = await shoppingListCategoryDao.getItemExist(refId, category);

          if(checked == 0 && exists){
            int recId = await shoppingListCategoryDao.getRecIdCategory(refId, category);
            shoppingListCategoryDao.delete(recId).then((delete){ 
              shoppingListCategoryDao.list(HomePage.refId);
            });
          }
          else if(checked > 0 && !exists){
            shoppingListCategoryDao.insert({
              'refid_shopplist': HomePage.refId,
              'list_name': HomePage.listName,
              'refid_category': map['recid'],
              'categorys': map['categorys'],
              'checked': map['checked'],
              'quantity_total': 0,
              'value_total': 0.00
            }).then((recid){
              shoppingListCategoryDao.list(HomePage.refId);
            });
          }
        }
      }
    }
    else{
      return;
    }
  }
}

updateQtyProduct(dynamic category, dynamic qty) async{
  ShoppingListCategoryDao shoppingListCategoryDao = ShoppingListCategoryDao();

  if(category != null && qty > 0){

    bool valid = await shoppingListCategoryDao.modifQtySelect(HomePage.refId, category, qty);

    if(!valid)
      shoppingListCategoryDao.updateSelect(HomePage.refId, category, 0.00, qty);
  }
}

updateVlProduct(dynamic category, dynamic vl) async{
  ShoppingListCategoryDao shoppingListCategoryDao = ShoppingListCategoryDao();

  if(category != null && vl > 0) {

    bool valid = await shoppingListCategoryDao.modifVlSelect(HomePage.refId, category, vl);

    if(!valid)
      shoppingListCategoryDao.updateSelect(HomePage.refId, category, vl);
  }
}
