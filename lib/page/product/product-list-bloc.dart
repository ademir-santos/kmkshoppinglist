import 'dart:async';

import 'package:kmkshoppinglist/dao/ProductDao.dart';

class ProductListBloc{

  ProductListBloc(categorys){
    getList(categorys);
  }

  final _controller = StreamController<List<Map>>.broadcast();

  ProductDao productDao = ProductDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(categorys) async{
    _controller.sink.add(await productDao.list(categorys));
  }
}