import 'dart:async';

import 'package:kmkshoppinglist/dao/ProductDao.dart';

class ProductListBloc{

  ProductListBloc(dynamic category){
    getList(category);
  }

  final _controller = StreamController<List<Map>>.broadcast();

  ProductDao productDao = ProductDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(dynamic category) async{
    _controller.sink.add(await productDao.list(category));
  }
}