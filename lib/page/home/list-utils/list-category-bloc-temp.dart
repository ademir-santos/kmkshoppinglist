import 'dart:async';

import 'package:kmkshoppinglist/dao/ShoppingListCategoryTempDao.dart';



class ListCategoryBlocTemp {
  
  static int refIdList;
  static String listName;

  final _controller = StreamController<List<Map>>.broadcast();

  ShoppingListCategoryTempDao shoppingListCategoryTempModel = ShoppingListCategoryTempDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(int refId) async{
    _controller.sink.add(await shoppingListCategoryTempModel.list(refId));
  }

  setValue(int refIdList, String listName){
     refIdList = refIdList;
    listName = listName;
  }
}