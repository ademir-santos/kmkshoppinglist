import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-widget.dart';

import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/home/home-widget.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-category/mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-product.dart';
import 'package:kmkshoppinglist/page/home/list-product/mirror-product.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-product-bloc-temp.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-page.dart';
import 'package:kmkshoppinglist/page/user/user.dart';
import 'package:kmkshoppinglist/utils/list-Category-util.dart';
import 'package:kmkshoppinglist/utils/list-product-util.dart';

class LayoutBase {

  static BottomNavigationBar bottomNavBar;

  static Drawer drawer;

  static AppBar appBar;

  static FloatingActionButton floatbottom;
  
  static void drawerBase(BuildContext context) {
    drawer = new Drawer(        
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
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: (){
                Navigator.of(context).pop(true);
                Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.tag, (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      );
  }

  static void appBarBase(page, ctx){
    
    switch (page) {
      case 'home-page':
        appBar = new AppBar(
          title: Text(' Lista de Compras'),
        );
        break;
      case 'category-page':
        appBar = new AppBar(
          title: Text(' Categorias'),
        );
        break;
        case 'user-page':
        appBar = new AppBar(
          title: Text(' Usuário'),
        );
        break;
      case 'product-page':
        appBar = new AppBar(
          title: Text(' Produtos'),
        );
        break;
      case 'list-mirror-category':
        appBar = new AppBar(
          title: Text(' Lista de Categoria'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                loadCategoryListTemp();
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(MirrorCategoryPage.tag);
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
        appBar = new AppBar(
          title: Text(' Selecionar Categoria'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {                
                loadCategoryList();
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(ListMirrorCategoryPage.tag);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Padding(padding: EdgeInsets.only(right: 20))
          ],   
        );
        break;
      case 'list-mirror-product':
        appBar = new AppBar(
          title: Text(' Lista de Produtos'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                loadProductListTemp();
                ListProductBlocTemp listProductBlocTemp = new ListProductBlocTemp();
                listProductBlocTemp.getList();
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(MirroProductPage.tag);
              },
              child: Icon(Icons.add_circle_outline),
            ),
            Padding(padding: EdgeInsets.only(right: 50)),
            GestureDetector(
              onTap: () {
                //ListProductBloc listProductBloc = ListProductBloc();
                //listProductBloc.getList(HomePage.refId, ListMirrorProductPage.categoryName);
                //updateQtyProduct(listProductBloc.lists);
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(ListMirrorCategoryPage.tag);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
          ],          
        );
        break;
      case 'mirror-product': 
        appBar = new AppBar(
          title: Text(' Selecionar Produto'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                loadProductList();
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pushReplacementNamed(ListMirrorProductPage.tag);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            Padding(padding: EdgeInsets.only(right: 20))
          ],   
        );
        break;
      default:
        appBar = new AppBar(
          title: Text(' Lista de Compras'),
        );
        break;
    }

  }
  
  static void btmNavBarBase(BuildContext context, currItem, pages){
    bottomNavBar = new BottomNavigationBar(
      currentIndex: currItem,
      fixedColor: LayoutWidget.primary(),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.question_answer), title: Text('Sobre')),
        // BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Configurações'))
      ],
      onTap: (int i) {
        currItem = i;
        Navigator.of(context).pushReplacementNamed(pages[i]);
      },
    );
  }

  static void floatingActionButtonBase(String page, BuildContext context){
    floatbottom = null;
    
    switch (page) {
      case 'home-page':
        floatbottom =  new FloatingActionButton(
          onPressed:(){
            HomeWidget.getAction(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        );
        break;
      case 'category-page':
        floatbottom = new FloatingActionButton(
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
  }

}