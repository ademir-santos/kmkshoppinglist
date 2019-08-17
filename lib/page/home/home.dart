import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home-list.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

class HomePage extends StatefulWidget{
  static String tag = 'home-page';

  HomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override   
  Widget build(BuildContext context) {
    final content = HomeListPage();

    return Layout.getContent(context, content, true, HomePage.tag);
  }
}