import 'dart:async';

import 'package:kmkshoppinglist/dao/ProductDao.dart';

class ProductListBloc{

  ProductListBloc(int refIdCategory){
    getList(refIdCategory);
  }

  final _controller = StreamController<List<Map>>.broadcast();

  ProductDao productDao = ProductDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(int refIdCategory) async{
    _controller.sink.add(await productDao.list(refIdCategory));
  }
}