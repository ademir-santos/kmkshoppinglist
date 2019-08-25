import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-widget.dart';
import 'package:kmkshoppinglist/page/home/home-widget.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-category/mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc.dart';
import 'package:kmkshoppinglist/utils/list-Category-util.dart';

class LayoutWidget extends StatelessWidget {
  
  static dynamic floatbottom;
  
  @override
  Widget build(BuildContext context) {
    return null;
  }

  static AppBar getAppBar(String page, BuildContext ctx) {
    switch (page) {
      case 'home-page':
        return AppBar(
          title: Text(' Lista de Compras'),
        );
        break;
      case 'category-page':
        return AppBar(
          title: Text(' Categorias'),
        );
        break;
        case 'user-page':
        return AppBar(
          title: Text(' Usuário'),
        );
        break;
      case 'product-page':
        return AppBar(
          title: Text(' Produtos'),
        );
        break;
      case 'list-mirror-category':
        return AppBar(
          title: Text(' Lista de Categoria'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(MirrorCategory.tag);
              },
              child: Icon(Icons.add_circle_outline),
            ),
            Padding(padding: EdgeInsets.only(right: 50)),
            GestureDetector(
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(HomePage.tag);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
            
          ],          
        );
        break;
      case 'mirror-category':
        return AppBar(
          title: Text(' Selecionar de Categoria'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                ListCategoryBlocTemp listBlocTemp = ListCategoryBlocTemp();
                ListCategoryBloc listCategoryBloc = ListCategoryBloc(HomePage.refId, HomePage.listName);
                listBlocTemp.getList(HomePage.refId);
                loadCategoryList(listBlocTemp.lists);
                listCategoryBloc.getList(HomePage.refId);

                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(ListMirrorCategory.tag);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Padding(padding: EdgeInsets.only(right: 20))
          ],   
        );
        break;
      case 'list-mirror-product':
        return AppBar(
          title: Text(' Lista de Produtos'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                //Navigator.of(ctx).pop();
                //Navigator.of(ctx).pushReplacementNamed(MirrorCategory.tag);
              },
              child: Icon(Icons.add_circle_outline),
            ),
            Padding(padding: EdgeInsets.only(right: 50)),
            GestureDetector(
              onTap: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(ListMirrorCategory.tag);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
          ],          
        );
        break;  
      default:
        return AppBar(
          title: Text(' Lista de Compras'),
        );
        break;
    }
  }

  static FloatingActionButton activeButtom(String page, BuildContext context){
    floatbottom = null;
    
    switch (page) {
      case 'home-page':
        floatbottom =  FloatingActionButton(
          onPressed:(){
            HomeWidget.getAction(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        );
        break;
      case 'category-page':
        floatbottom = FloatingActionButton(
          onPressed:(){
            CategoryWidget.getAction(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ); // This trailing com
        break;
      default:
        floatbottom = null;
        break;
    }

    return floatbottom;
  }

  Widget buildInfo() {
    return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CircleAvatar(
                       backgroundColor: Colors.blueAccent,
                       //backgroundImage: NetworkImage("${person.urlImage}"),
                    )
                  ]
                )
              ]
            )
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