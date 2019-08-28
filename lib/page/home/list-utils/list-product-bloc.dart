import 'dart:async';

import 'package:kmkshoppinglist/dao/ShopplistCategoryProductDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-home-category.dart';

class ListProductBloc {

  ListProductBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  final ShopplistCategoryProductDao shopplistCategoryProductDao = new ShopplistCategoryProductDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await shopplistCategoryProductDao.loadList(HomePage.refId,ListHomeCategory.categoryName));
  }
}