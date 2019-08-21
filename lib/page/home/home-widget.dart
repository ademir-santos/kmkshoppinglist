import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/models/UserShoppingListModel.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class HomeWidget {

  static setShoppList(BuildContext ctx, String shoppList){

    UserShoppingListModel userShoppingListModel = UserShoppingListModel();

    userShoppingListModel.insert({
      'list_name': shoppList.toUpperCase(),
      'created': DateTime.now().toString(),
      'refid_user': 1
    }).then((recId){
      Navigator.of(ctx).pop();
      Navigator.of(ctx).pushReplacementNamed(HomePage.tag);
    });    
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
                setShoppList(ctx, _sh.text);
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

  static void showEditDialog(BuildContext context, Map shoppList){
    TextEditingController _sh = TextEditingController();

    _sh.text = shoppList['list_name'];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        final inputLitName = TextFormField(
          controller: _sh,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Lista de compra',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        return AlertDialog(
          title: Text('Editar lista'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                inputLitName
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                UserShoppingListModel userShoppingListModel = UserShoppingListModel();
                userShoppingListModel.update({
                  'list_name': _sh.text.toUpperCase()
                }, shoppList['recid']).then((saved){
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pushReplacementNamed(HomePage.tag);
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