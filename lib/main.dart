import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

void main() => runApp(KMKShoppingList());

class KMKShoppingList extends StatelessWidget {
  
  final routes = <String, WidgetBuilder> {
    HomePage.tag: (context) => HomePage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Lista de Compra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Layout.primary()
      ),
      home: HomePage(title: 'Lista de Compra'),
      routes: routes,
    );
  }
}