import 'dart:async';

import 'package:kmkshoppinglist/dao/UserShoppingListDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

class HomeListBloc {

  HomeListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  final UserShoppingListDao userShoppingListDao = UserShoppingListDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await userShoppingListDao.list(HomePage.userRecId));
  }
}