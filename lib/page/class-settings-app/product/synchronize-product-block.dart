import 'dart:async';

import 'package:kmkshoppinglist/json-class/product/product-json.dart';
import 'package:kmkshoppinglist/json-class/product/product-model-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';
import 'package:kmkshoppinglist/page/category/category.dart';

class SynchronizeProductBlock {
  final LoginModelJson _json;

  SynchronizeProductBlock(this._json) {
  }

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    if(postOrGet == "post")
      _controller.sink.add(await allPostsListBloc(await fetchPostProduct(this._json), CategoryPage.categorys));
    else
      _controller.sink.add(await allPostsListBloc(await fetchGetProduct(this._json), CategoryPage.categorys));
  }
}