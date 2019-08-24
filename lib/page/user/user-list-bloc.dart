import 'dart:async';

import 'package:kmkshoppinglist/dao/UserDao.dart';

class UserListBloc{

  UserListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  UserDao userDao = UserDao();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await userDao.list(0));
  }
}