import 'dart:async';

import 'package:kmkshoppinglist/models/ProductModel.dart';

class ProductListBloc{

  ProductListBloc(int refIdCategory){
    getList(refIdCategory);
  }

  final _controller = StreamController<List<Map>>.broadcast();

  ProductModel productModel = ProductModel();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(int refIdCategory) async{
    _controller.sink.add(await productModel.list(refIdCategory));
  }
}