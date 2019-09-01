import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/dao/LoginDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

class LoginServices {
  static String email = '';
  static String user = '';
  static String password = '';
  static int userRecId = 0;

  validadeLogin(BuildContext context, String login, String password) async{
    
    if(login.isNotEmpty && password.isNotEmpty){
      LoginDao loginDao = LoginDao();
      Map ret = await loginDao.login(login, password);

      if(ret.isNotEmpty) {

        user = ret['users'];
        email = ret['email'];
        userRecId = ret['recid'];
        password = ret['password'];
        HomePage.email = email;
        HomePage.user = user;
        HomePage.password = password;
        HomePage.userRecId = userRecId;
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(HomePage.tag);

      } else {

        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro de acesso'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Usuário ou senha invalidos!'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}