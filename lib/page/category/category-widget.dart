import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-list.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class CategoryWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return null;
  }

  //Adiciona categoria na lista
  static setCategory(String cat) {
    CategoryListPage.category.add(
      ListTile(
        leading: CircleAvatar(
          backgroundColor: LayoutWidget.primary(),
          child: Text('C'),
          foregroundColor: Colors.white,
        ),
        title: Text(cat),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          
        },
      ),
    );
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
                print(_c1.text);
                CategoryWidget.setCategory(_c1.text);
                Navigator.of(ctx).popAndPushNamed(CategoryPage.tag);
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
}