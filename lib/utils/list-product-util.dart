import 'package:kmkshoppinglist/dao/ShopplistCategoryProductDao.dart';
import 'package:kmkshoppinglist/dao/ShopplistCategoryProductTempDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-home-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-product-bloc-temp.dart';
import 'package:kmkshoppinglist/page/product/product-list-bloc.dart';

loadProductListTemp() async{
  
  ShopplistCategoryProductTempDao shopplistCategoryProductTempDao = ShopplistCategoryProductTempDao();

  ProductListBloc productListBloc = ProductListBloc(ListHomeCategory.categoryName);

  bool exists = false;

  productListBloc.getList(ListHomeCategory.categoryName);

  Stream<List<Map>> futureList = productListBloc.lists;

  await for(var mapList in futureList){
    if(mapList.isNotEmpty){
      for(var map in mapList){
        String category = map['categorys'];
        String product = map['products'];
        int refIdList = HomePage.refId;

        if(category.isNotEmpty){
          exists = await shopplistCategoryProductTempDao.getItemExist(refIdList, category, product);

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

loadProductList() async{

  ShopplistCategoryProductDao shopplistCategoryProductDao = ShopplistCategoryProductDao();

  ListProductBlocTemp listProducBlocTemp = ListProductBlocTemp();
  
  bool exists = false;

  listProducBlocTemp.getList();

  Stream<List<Map>> futureList = listProducBlocTemp.lists;

  await for(var mapList in futureList){
    if(mapList.isNotEmpty){
      for(var map in mapList){
        String category = map['categorys'];
        String product = map['products'];
        int checked = map['checked'];
        int refId = HomePage.refId;

        if(category.isNotEmpty){
          exists = await shopplistCategoryProductDao.getItemExist(refId, category, product);

          if(checked == 0 && exists){
            int recId = await shopplistCategoryProductDao.getRecId(refId, category, product);
            shopplistCategoryProductDao.delete(recId).then((delete){ 
              shopplistCategoryProductDao.list(HomePage.refId);
            });
          } else if(checked > 0 && !exists){
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