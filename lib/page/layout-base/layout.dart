import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
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
    LoginPage.tag,
    LoginAddPage.tag,
    HomePage.tag,
    ListMirrorCategoryPage.tag,
    ListMirrorProductPage.tag,
    MirrorCategoryPage.tag,
    MirroProductPage.tag,
    CategoryPage.tag,
    ProductPage.tag,
    UserPage.tag
  ];

  static final tag = 'Exit'; 
  static int currItem = 0;

  static Scaffold getContent(BuildContext context, content, [bool showbottom = false, String page = 'home-page']) {
    
    LayoutBase.drawerBase(context);

    LayoutBase.appBarBase(page, context);

    if(showbottom == true) {
      LayoutWidget.activeButtom(page, context);
    }

    return Scaffold(

      appBar: LayoutBase.appBar,

      drawer:  LayoutBase.drawer,

      body: new Builder( builder: (BuildContext context) { Layout.scaffoldContext = context; return content; }, ),

      floatingActionButton: LayoutWidget.floatbottom,
    );
  }
}