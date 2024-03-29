import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/dao/UserDao.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/user/user.dart';

class UserWidget {

  static setUser(BuildContext ctx, String users, String password, String name) {

    UserDao userDao = UserDao();

    userDao.insert({
      'users': users,
      'password': password,
      'name': name
    }).then((recId){
      Navigator.of(ctx).pop();
      Navigator.of(ctx).popAndPushNamed(UserPage.tag);
    });
  }

  static List<Widget> getAction(context) {
    TextEditingController _u = TextEditingController();
    TextEditingController _p = TextEditingController();
    TextEditingController _n = TextEditingController();
    List<Widget> items = List<Widget>();

    final Widget value = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Cadastro de Usuario'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _u,
                  decoration: InputDecoration(
                    hintText: 'Informe o login',
                  ),
                ),
                TextFormField(
                  controller: _p,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Informe o senha',
                  ),
                ),
                TextFormField(
                  controller: _n,
                  decoration: InputDecoration(
                    hintText: 'Informe o primeiro nome',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                setUser(ctx, _u.text, _p.text, _n.text.substring(0,1).toUpperCase()+_n.text.substring(1));
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

  static void showEditDialog(BuildContext context, Map user){
    TextEditingController _u = TextEditingController();
    TextEditingController _p = TextEditingController();
    TextEditingController _n = TextEditingController();
    TextEditingController _e = TextEditingController();

    _u.text = user['users'];
    _p.text = user['password'];
    _n.text = user['name'];
    _e.text = user['email'];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        final inputName = TextFormField(
          controller: _n,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Nome',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        final inputUsers= TextFormField(
          controller: _u,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Usuário',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        final inputEmail= TextFormField(
          controller: _e,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        final inputPassWord  = TextFormField(
          controller: _p,
          autofocus: true,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Senha',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        return AlertDialog(
          title: Text('Editar Usuário'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nome'),
                SizedBox(height: 15),
                inputName,
                SizedBox(height: 15),
                Text('Usuário'),
                SizedBox(height: 15),
                inputUsers,
                SizedBox(height: 15),
                Text('E-mail'),
                SizedBox(height: 15),
                inputEmail,
                SizedBox(height: 15),
                Text('Senha'),
                SizedBox(height: 15),
                inputPassWord
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                UserDao userDao = UserDao();
                userDao.update({
                  'users': _u.text.toLowerCase(),
                  'password': _p.text,
                  'name': _n.text.substring(0,1).toUpperCase()+_n.text.substring(1),
                  'email': _e.text
                }, user['recid']).then((saved){
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pushReplacementNamed(UserPage.tag);
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