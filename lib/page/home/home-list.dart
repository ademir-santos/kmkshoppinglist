import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home-widget.dart';

class HomeListPage extends StatefulWidget {
  
  static List<Widget> shoppList = List<Widget>();

  @override
  HomeListPageState createState() => HomeListPageState();
}

class HomeListPageState extends State<HomeListPage> {
  
  @override
  Widget build(BuildContext context) {
    
    HomeWidget.getShoppList();

    List<Widget> value = List<Widget>();

    if(HomeListPage.shoppList.length == 0) {

      Widget addWidget = ListView (
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.pages),
              title: Text('Nenhuma lista de compra cadastrada ainda...'),
            )
          ],
        );

      value.add(addWidget);
    }

    return  Container();//(HomeListPage.shoppList.length == 0) ? value :  HomeListPage.shoppList;
  }
}