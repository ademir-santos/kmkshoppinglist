import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home-list-bloc.dart';
import 'package:kmkshoppinglist/page/home/home-list.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

class HomePage extends StatefulWidget{
  static String tag = 'home-page';
  static String email = '';
  static String user = '';
  static int userRecId = 0;

  HomePage({Key key, this.title}) : super(key:key);

  final String title;
  static int refId = 0;
  static String listName;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeListBloc listBloc = HomeListBloc();

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
              return HomeListPage(key: widget.key,shoppList: snapshot.data);
            }
            break;
        }
      },
    );

    return Layout.getContent(context, content, true, HomePage.tag);
  }
}