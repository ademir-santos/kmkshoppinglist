import 'dart:async';

import 'package:kmkshoppinglist/dao/ProductDao.dart';
import 'package:kmkshoppinglist/json-class/product/product-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';
import 'package:kmkshoppinglist/page/category/category.dart';

class SynchronizeProductBlock {
  final LoginModelJson _json;
  final ProductDao dao = ProductDao();

  SynchronizeProductBlock(this._json) {
  }

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async {
    if(postOrGet == "post") {
      try {
        await fetchPostProduct(this._json);
        _controller.sink.add(await dao.list(CategoryPage.categorys));
      } catch(Exception){
        _controller.sink.add(await dao.list(CategoryPage.categorys));
      }
    } else {
      try{
        await fetchGetProduct(this._json);
        _controller.sink.add(await dao.list(CategoryPage.categorys));
      }catch(Exception){
        _controller.sink.add(await dao.list(CategoryPage.categorys));
      }
    }
  }
}