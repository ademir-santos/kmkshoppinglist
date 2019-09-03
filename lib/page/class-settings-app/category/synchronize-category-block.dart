import 'dart:async';

import 'package:kmkshoppinglist/dao/CategoryDao.dart';
import 'package:kmkshoppinglist/json-class/category/category-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';

class SynchronizeCategoryBlock {
  final LoginModelJson _json;
  final CategoryDao dao = CategoryDao();

  SynchronizeCategoryBlock(this._json) {
  }

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    if(postOrGet == "post"){
      fetchPostCategory(this._json);
      _controller.sink.add(await dao.list(0));
    } else {
      fetchGetCategory(this._json);
      _controller.sink.add(await dao.list(0));
    }  
  }
}