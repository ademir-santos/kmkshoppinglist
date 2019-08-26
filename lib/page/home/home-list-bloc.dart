import 'dart:async';

import 'package:kmkshoppinglist/dao/UserShoppingListDao.dart';



class HomeListBloc {

  HomeListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  UserShoppingListDao userShoppingListDao = UserShoppingListDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await userShoppingListDao.list(1));
  }
}