import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  
  static dynamic floatbottom;
  
  @override
  Widget build(BuildContext context) {
    return null;
  }

  static AppBar getAppBar(String page) {
    switch (page) {
      case 'home-page':
        return AppBar(
          title: Text('(K.M.K APP) Lista de Compras'),
        );
        break;
      case 'category-page':
        return AppBar(
          title: Text('(K.M.K APP) Lista de Categorias'),
        );
      break;  
      default:
        return AppBar(
          title: Text('(K.M.K APP) Lista de Compras'),
        );
        break;
    }
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