import 'dart:async';

import 'package:kmkshoppinglist/Dao/ShoppingListCategoryDao.dart';

class ListCategoryBloc {

  static int refIdList;
  static String listName;

  ListCategoryBloc(int refIdList, String listName){
    setValue(refIdList, listName);
  }

  final _controller = StreamController<List<Map>>.broadcast();

  ShoppingListCategoryDao shoppingListCategoryModel = ShoppingListCategoryDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(int refIdList) async{
    _controller.sink.add(await shoppingListCategoryModel.list(refIdList));
  }

  getListName(){
    return listName;
  }

  getListId(){
    return refIdList;
  }

  setValue(int refIdList, String listName){
    refIdList = refIdList;
    listName = listName;
  }
}