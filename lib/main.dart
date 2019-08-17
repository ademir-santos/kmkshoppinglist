import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

void main() => runApp(KMKShoppingList());

class KMKShoppingList extends StatelessWidget {
  
  final routes = <String, WidgetBuilder> {
    HomePage.tag: (context) => HomePage(),
    CategoryPage.tag: (context) => CategoryPage()
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
          headline: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: LayoutWidget.primary()),
          body1: TextStyle(fontSize: 14)
        )
      ),
      home: HomePage(title: 'Lista de Compra'),
      routes: routes,
    );
  }
}