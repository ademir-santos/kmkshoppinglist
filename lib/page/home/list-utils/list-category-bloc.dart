import 'dart:async';

import 'package:kmkshoppinglist/Dao/ShoppingListCategoryDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

class ListCategoryBloc {

  ListCategoryBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  final ShoppingListCategoryDao shoppingListCategoryModel = ShoppingListCategoryDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await shoppingListCategoryModel.list(HomePage.refId));
  }
}