import 'dart:async';

import 'package:kmkshoppinglist/dao/UserShoppingListDao.dart';



class HomeListBloc {

  HomeListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  UserShoppingListDao userShoppingListModel = UserShoppingListDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await userShoppingListModel.list(1));
  }
}