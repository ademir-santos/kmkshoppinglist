import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-page.dart';
import 'package:kmkshoppinglist/page/user/user.dart';

class Layout {
  static final tag = 'Exit'; 
  static BuildContext scaffoldContext;
  static int currItem = 0;

  static Scaffold getContent(BuildContext context, content, [bool showbottom = false, String page = 'home-page']) {

    if(showbottom == true) {
      LayoutWidget.activeButtom(page, context);
    }

    return Scaffold(
      appBar: LayoutWidget.getAppBar(page, context),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(HomePage.user),
              accountEmail: new Text(HomePage.email),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(HomePage.user.substring(0,1)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Principal'),
              trailing: new Icon(Icons.arrow_back),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(HomePage.tag);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.loyalty),
              title: Text('Categoria / produto'),
              trailing: new Icon(Icons.arrow_back),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(CategoryPage.tag);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Usuários'),
              trailing: new Icon(Icons.arrow_back),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(UserPage.tag);
              },
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(top: 210)),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Sair'),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.tag, (Route<dynamic> route) => false);
                exit(0);
              },
            ),
          ],
        ),
      ),
      body: content,
      floatingActionButton: LayoutWidget.floatbottom,
    );
  }
}