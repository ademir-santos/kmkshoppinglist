import 'dart:async';

import 'package:kmkshoppinglist/models/CategoryModel.dart';

class CategoryListBloc {

  CategoryListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  CategoryModel categoryModel = CategoryModel();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await categoryModel.list(0));
  }
}