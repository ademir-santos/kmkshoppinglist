import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/dao/LoginDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

class LoginServices {

  validadeLogin(BuildContext context, String login, String password) async{
    
    if(login.isNotEmpty && password.isNotEmpty){
      LoginDao loginDao = LoginDao();
      bool ret = await loginDao.login(login, password);

      if(ret){
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(HomePage.tag);
      }
    }
  }
}