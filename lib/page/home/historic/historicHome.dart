import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

import 'historic-list-bloc.dart';
import 'historic-list.dart';

class HistoricHomePage extends StatefulWidget {

  static String tag = 'historic-page';
  
  static String user = HomePage.user;

  static String password = HomePage.password;
  
  static String email = HomePage.email;
  
  static int userRecId = HomePage.refId;

  @override
  _HistoricHomePageState createState() => _HistoricHomePageState();
}

class _HistoricHomePageState extends State<HistoricHomePage> {

  final HistoricListBloc historicListBloc = HistoricListBloc();

  @override
  void dispose() {
    historicListBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final content = StreamBuilder<List<Map>>(
      stream: historicListBloc.lists,
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
              return HistoricListPage(key: widget.key,shoppList: snapshot.data);
            }
            break;
        }
      },
    );

    return Layout.getContent(context, content, true, HistoricHomePage.tag);
  }
}