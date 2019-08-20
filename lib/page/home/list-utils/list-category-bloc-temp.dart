import 'dart:async';

import 'package:kmkshoppinglist/models/ShoppingListCategoryTempModel.dart';



class ListCategoryBlocTemp {
  
  static int refIdList;
  static String listName;

  final _controller = StreamController<List<Map>>.broadcast();

  ShoppingListCategoryTempModel shoppingListCategoryTempModel = ShoppingListCategoryTempModel();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await shoppingListCategoryTempModel.list(0));
  }

  setValue(int refIdList, String listName){
     refIdList = refIdList;
    listName = listName;
  }
}