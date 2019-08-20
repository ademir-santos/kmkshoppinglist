import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';
import 'package:kmkshoppinglist/page/user/user-list-bloc.dart';
import 'package:kmkshoppinglist/page/user/user-list.dart';

class UserPage extends StatefulWidget {
  static final tag = 'user-page';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserListBloc listBloc = UserListBloc();


  @override
  void dispose() {
    listBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = StreamBuilder<List<Map>>(
      stream: listBloc.lists,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
            break;
          default:
            if(snapshot.hasError){
              print(snapshot.hasError);
              return Text('Erro: ${snapshot.error}');
            }
            else{
              return UserListPage(user: snapshot.data);
            }
            break;
        }
      },
    );

    return Layout.getContent(context, content, true, UserPage.tag);
  }
}