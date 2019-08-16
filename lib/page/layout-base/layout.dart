import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

class Layout {
  static BuildContext scaffoldContext;
  static int currItem = 0;


  static Scaffold getContent(BuildContext context, content, [bool showbottom = true]) {

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
              title: Text('Lista de compra'),
              onTap: (){
                Navigator.of(context).pushNamed(HomePage.tag);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('(K.M.K APP) Lista de Compras'),
      ),
      body: content,
    );
  }

  static Color primary([double opacity = 1]) => Color.fromRGBO(62, 63, 89, opacity);

  static Color secondary([double opacity = 1]) => Color.fromRGBO(111, 168, 191, opacity);

  static Color light([double opacity = 1]) => Color.fromRGBO(242, 234, 228, opacity);

  static Color dark([double opacity = 1]) => Color.fromRGBO(51, 51, 51, opacity);

  static Color danger([double opacity = 1]) => Color.fromRGBO(217, 74, 74, opacity);

  static Color success([double opacity = 1]) => Color.fromRGBO(6, 166, 59, opacity);

  static Color info([double opacity = 1]) => Color.fromRGBO(0, 123, 166, opacity);

  static Color warning([double opacity = 1]) => Color.fromRGBO(166, 134, 0, opacity);
}