import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-widget.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class Layout {
  static BuildContext scaffoldContext;
  static int currItem = 0;


  static Scaffold getContent(BuildContext context, content, [bool showbottom = false, String page = 'home-page']) {

    dynamic floatbottom;

    if(showbottom == true) {
        floatbottom = FloatingActionButton(
          onPressed:(){
            CategoryWidget.getAction(context);
          },

          tooltip: 'Increment',
          child: Icon(Icons.add),
      ); // This trailing com
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Principal'),
              onTap: (){
                Navigator.of(context).pushNamed(HomePage.tag);
              },
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Categoria de produto'),
              onTap: (){
                Navigator.of(context).pushNamed(CategoryPage.tag);
              },
            )
          ],
        ),
      ),
      appBar: LayoutWidget.getAppBar(page),
      body: content,
      floatingActionButton: floatbottom,
    );
  }
}