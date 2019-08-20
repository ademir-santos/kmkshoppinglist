import 'dart:async';

import 'package:kmkshoppinglist/models/UserModel.dart';

class UserListBloc{

  UserListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  UserModel userModel = UserModel();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await userModel.list(0));
  }
}