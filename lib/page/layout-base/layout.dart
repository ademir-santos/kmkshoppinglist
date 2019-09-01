import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/home/historic.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-category/mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-product.dart';
import 'package:kmkshoppinglist/page/home/list-product/mirror-product.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-base.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-add.dart';
import 'package:kmkshoppinglist/page/login/login-page.dart';
import 'package:kmkshoppinglist/page/product/product.dart';
import 'package:kmkshoppinglist/page/user/user.dart';

class Layout extends LayoutBase{

  static BuildContext scaffoldContext;

  static final pages = [
    HomePage.tag,
    //AboutPage.tag,
    //SettingsPage.tag
  ];

  static final pagesHome = [
    HomePage.tag,
    HistoricoPage.tag,
  ];

  static final tag = 'Exit'; 
  static int currItem = 0;

  static Scaffold getContent(BuildContext context, content, [bool showbottom = false, String page = 'home-page']) {
    
    LayoutBase.drawerBase(context);

    LayoutBase.appBarBase(page, context);

    BottomNavigationBar bottomNavBar = null;

    if(showbottom == true) {
      //LayoutBase.activeButtom(page, context);
    } else {

    }
  
    if((page == 'home-page') || (page == "historic-page")) {
      
      bottomNavBar = BottomNavigationBar(
        currentIndex: currItem,
        fixedColor: LayoutWidget.primary(),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.question_answer), title: Text('Historico de lista')),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Sobre'))
        ],
        onTap: (int i) {
          currItem = i;
          Navigator.of(context).pushReplacementNamed(pagesHome[i]);
        },
      );

    } 


    return Scaffold(

      appBar: LayoutBase.appBar,

      drawer:  LayoutBase.drawer,

      bottomNavigationBar: bottomNavBar,

      body: new Builder( builder: (BuildContext context) { Layout.scaffoldContext = context; return content; }, ),

      //floatingActionButton: LayoutWidget.floatbottom,
    );
  }
}