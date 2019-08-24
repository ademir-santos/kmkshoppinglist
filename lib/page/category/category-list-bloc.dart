import 'dart:async';

import 'package:kmkshoppinglist/dao/CategoryDao.dart';

class CategoryListBloc {

  CategoryListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  CategoryDao categoryDao = CategoryDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await categoryDao.list(0));
  }
}