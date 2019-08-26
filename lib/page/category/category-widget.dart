import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/dao/CategoryDao.dart';

class CategoryWidget {

  //Adiciona categoria na lista
  static setCategory(BuildContext ctx, String cat) {
    String category = cat.substring(0,1).toUpperCase()+cat.substring(1);
    CategoryDao categoryDao = CategoryDao();

    categoryDao.insert({
      'categorys': category,
      'qty_product': 0
    }).then((recId){
      Navigator.of(ctx).pop();
      Navigator.of(ctx).popAndPushNamed(CategoryPage.tag);
    });
  }

  //Formulario para criar categoria
  static List<Widget> getAction(context) {
    TextEditingController _c1 = TextEditingController();
    List<Widget> items = List<Widget>();

    final Widget value = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Cadastro de categoria'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _c1,
                  decoration: InputDecoration(
                    hintText: 'Nome da categoria',
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
                CategoryWidget.setCategory(ctx, _c1.text);
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
    
    items.add(value);

    return items;
  }

  static void showEditDialog(BuildContext context, Map category){
    TextEditingController _c = TextEditingController();
    _c.text = category['categorys'];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        final input = TextFormField(
          controller: _c,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Categoria',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        return AlertDialog(
          title: Text('Editar Categoria'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                input
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                CategoryDao categoryDao = CategoryDao();
                categoryDao.update({
                  'categorys': _c.text.substring(0,1).toUpperCase()+_c.text.substring(1)
                }, category['recid']).then((saved){
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pushReplacementNamed(CategoryPage.tag);
                });
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
      }
    );
  }
}