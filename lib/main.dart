import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/home/historic.dart';
import 'package:kmkshoppinglist/page/home/historic/historicHome.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-category/mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-product.dart';
import 'package:kmkshoppinglist/page/home/list-product/mirror-product.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-add.dart';
import 'package:kmkshoppinglist/page/login/login-page.dart';
import 'package:kmkshoppinglist/page/product/product.dart';
import 'package:kmkshoppinglist/page/sync/data-sync-category.dart';
import 'package:kmkshoppinglist/page/user/user.dart';

import 'page/class-settings-app/category/synchronize-category-circular-progress.dart';
import 'page/class-settings-app/product/synchronize-product-circular-progress.dart';

void main() => runApp(KMKShoppingList());

class KMKShoppingList extends StatelessWidget {

  final routes = <String, WidgetBuilder> {
    LoginPage.tag: (context) => LoginPage(),
    LoginAddPage.tag: (context) => LoginAddPage(),
    HomePage.tag: (context) => HomePage(), 
    ListMirrorCategoryPage.tag: (context) => ListMirrorCategoryPage(),
    ListMirrorProductPage.tag: (context) => ListMirrorProductPage(),
    MirrorCategoryPage.tag: (context) => MirrorCategoryPage(),
    MirroProductPage.tag: (context) => MirroProductPage(),
    CategoryPage.tag: (context) => CategoryPage(),
    ProductPage.tag: (context) => ProductPage(),
    UserPage.tag: (context) => UserPage(),
    DataSyncCaTegoryPage.tag: (context) => DataSyncCaTegoryPage(),
    
    //Sincronization tables
    SynchronizeCategoryCircularProgress.tag: (context) => SynchronizeCategoryCircularProgress(),
    SynchronizeProductCircularProgress.tag: (context) => SynchronizeProductCircularProgress(),

    //Historicos de compras
    HistoricHomePage.tag: (context) => HistoricHomePage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Lista de Compra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: LayoutWidget.primary(),
        accentColor: LayoutWidget.secondary(),
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: LayoutWidget.primary()),
          body1: TextStyle(fontSize: 14)
        )
      ),
      home: LoginPage(),
      routes: routes
    );
  }
}