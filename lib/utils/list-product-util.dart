
import 'package:kmkshoppinglist/dao/ShopplistCategoryProductDao.dart';
import 'package:kmkshoppinglist/dao/ShopplistCategoryProductTempDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

loadProductListTemp(Stream<List<Map>> futureList) async{
  ShopplistCategoryProductTempDao shopplistCategoryProductTempDao = ShopplistCategoryProductTempDao();
  bool exists = false;

  await for(var mapList in futureList){
    if(mapList.isNotEmpty){
      for(var map in mapList){
        String category = map['categorys'];
        String product = map['products'];
        int refId = HomePage.refId;

        if(category.isNotEmpty){
          exists = await shopplistCategoryProductTempDao.getItemExist(refId, category, product);

          if(!exists){
            shopplistCategoryProductTempDao.insert({
              'refid_shopplist': HomePage.refId,
              'list_name': HomePage.listName,
              'refid_category': map['refid_category'],
              'categorys': map['categorys'],
              'refid_product': map['recid'],
              'products': map['products'],
              'quantity': 1,
              'value_unitary': 0.00,
              'quantity_total': 1,
              'value_total': 0.00,
              'checked': 0,
              'created': DateTime.now().toString()
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

loadProductList(Stream<List<Map>> futureList) async{
  ShopplistCategoryProductDao shopplistCategoryProductDao = ShopplistCategoryProductDao();
  bool exists = false;

  await for(var mapList in futureList){
    if(mapList.isNotEmpty){
      for(var map in mapList){
        String category = map['categorys'];
        String product = map['products'];
        int refId = HomePage.refId;

        if(category.isNotEmpty){
          exists = await shopplistCategoryProductDao.getItemExist(refId, category, product);

          if(!exists){
            shopplistCategoryProductDao.insert({
              'refid_shopplist': map['refid_shopplist'],
              'list_name': map['list_name'],
              'refid_category': map['refid_category'],
              'categorys': map['categorys'],
              'refid_product': map['recid'],
              'products': map['products'],
              'quantity': 1,
              'value_unitary': 0.00,
              'quantity_total': 1,
              'value_total': 0.00,
              'checked': 1,
              'created': DateTime.now().toString()
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