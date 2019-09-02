import 'dart:async';

import 'package:kmkshoppinglist/json-class/category/category-json.dart';
import 'package:kmkshoppinglist/json-class/category/category-model-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';

class SynchronizeCategoryBlock {
  final LoginModelJson _json;

  SynchronizeCategoryBlock(this._json) {
  }

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    if(postOrGet == "post")
      _controller.sink.add(await allPostsListBloc(await fetchPostCategory(this._json)));
    else
      _controller.sink.add(await allPostsListBloc(await fetchGetCategory(this._json)));
  }
}