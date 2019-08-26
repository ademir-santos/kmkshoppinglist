import 'dart:async';

import 'package:kmkshoppinglist/dao/ShopplistCategoryProductTempDao.dart';

class ListProductBlocTemp {
  final _controller = StreamController<List<Map>>.broadcast();

  ShopplistCategoryProductTempDao shopplistCategoryProductTempDao = ShopplistCategoryProductTempDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(dynamic refIdList, dynamic category) async{
    _controller.sink.add(await shopplistCategoryProductTempDao.loadList(refIdList, category));
  }
}