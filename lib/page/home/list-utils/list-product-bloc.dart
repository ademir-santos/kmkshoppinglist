import 'dart:async';

import 'package:kmkshoppinglist/dao/ShopplistCategoryProductDao.dart';

class ListProductBloc {
  final _controller = StreamController<List<Map>>.broadcast();

  ShopplistCategoryProductDao shopplistCategoryProductDao = ShopplistCategoryProductDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList(dynamic refIdList, dynamic category) async{
    _controller.sink.add(await shopplistCategoryProductDao.loadList(refIdList, category));
  }
}