import 'dart:async';

import 'package:kmkshoppinglist/models/ShoppingListCategoryModel.dart';



class ListCategoryBloc {

  static int refIdList;
  static String listName;

  final _controller = StreamController<List<Map>>.broadcast();

  ShoppingListCategoryModel shoppingListCategoryModel = ShoppingListCategoryModel();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(int refIdList) async{
    _controller.sink.add(await shoppingListCategoryModel.list(refIdList));
  }

  setValue(int refIdList, String listName){
     refIdList = refIdList;
    listName = listName;
  }
}