import 'dart:async';

import 'package:kmkshoppinglist/dao/ShopplistCategoryProductTempDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-product.dart';

class ListProductBlocTemp {

  ListProductBlocTemp(){
    getList();
  }
  
  final _controller = StreamController<List<Map>>.broadcast();

  final ShopplistCategoryProductTempDao shopplistCategoryProductTempDao = new ShopplistCategoryProductTempDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await shopplistCategoryProductTempDao.loadList(HomePage.refId, ListMirrorProductPage.categoryName));
  }
}