import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/dao/LoginDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

class LoginServices {
  static String email = '';
  static String user = '';
  static int userRecId = 0;

  validadeLogin(BuildContext context, String login, String password) async{
    
    if(login.isNotEmpty && password.isNotEmpty){
      LoginDao loginDao = LoginDao();
      Map ret = await loginDao.login(login, password);

      if(ret.isNotEmpty) {
        user = ret['users'];
        email = ret['email'];
        userRecId = ret['recid'];
        HomePage.email = email;
        HomePage.user = user;
        HomePage.userRecId = userRecId;
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(HomePage.tag);
      }
    }
  }
}