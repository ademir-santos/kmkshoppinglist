import 'dart:async';

import 'package:kmkshoppinglist/models/UserShoppingListModel.dart';



class HomeListBloc {

  HomeListBloc(){
    getList();
  }

  final _controller = StreamController<List<Map>>.broadcast();

  UserShoppingListModel userShoppingListModel = UserShoppingListModel();

  get lists => _controller.stream;

  dipose(){
    _controller.close();
  }

  getList() async{
    _controller.sink.add(await userShoppingListModel.list(1));
  }
}