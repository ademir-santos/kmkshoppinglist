import 'dart:async';

import 'package:kmkshoppinglist/dao/ShoppingListCategoryTempDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

class ListCategoryBlocTemp {

  ListCategoryBlocTemp(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  final ShoppingListCategoryTempDao shoppingListCategoryTempModel = ShoppingListCategoryTempDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await shoppingListCategoryTempModel.list(HomePage.refId));
  }
}