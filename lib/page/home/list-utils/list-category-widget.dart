import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/Dao/ShoppingListCategoryDao.dart';
import 'package:kmkshoppinglist/page/category/category-list-bloc.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class ListCategoryWidget {
  
  static int refIdShoppList = 0;
  static CategoryListBloc listBloc = CategoryListBloc();
  
  static void setShoppList(BuildContext ctx, int refIdShoppList, String listName, Map category){

    ShoppingListCategoryDao shoppingListCategoryModel = ShoppingListCategoryDao();

    shoppingListCategoryModel.insert({
      'refid_shopplist': refIdShoppList,
      'list_name': listName,
      'refid_category': category['recid'],
      'category': category['category'],
      'checked': 1,
      'created': DateTime.now().toString()
    }).then((recId){
      //Navigator.of(ctx).pop();
      //Navigator.of(ctx).popAndPushNamed(ListMirrorCategory.tag);
    });    
  }

  static void setcategoryList(BuildContext ctx, int reIdShoppList, String listName, Map category){
    setShoppList(ctx, reIdShoppList, listName, category);
  }

  //Formulario para criar categoria
  static List<Widget> getAction(context) {
    TextEditingController _sh = TextEditingController();
    List<Widget> items = List<Widget>();

    Widget valueDialog = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Cadastro de lista de compra'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _sh,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Nome da lista',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                print(_sh.text);
                //setShoppList(ctx, _sh.text);
                //Navigator.of(ctx).popAndPushNamed(HomePage.tag);
              },
            ),

            FlatButton(
              color: LayoutWidget.danger(),
              child: Text('Cancelar', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        );
      },
    ) as Widget;

    items.add(valueDialog);

    return items;
  }

}