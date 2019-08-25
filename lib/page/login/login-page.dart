import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-add.dart';
import 'package:kmkshoppinglist/page/login/login-services.dart';

class LoginPage extends StatelessWidget {

  static final tag = 'login-page';

  @override
  Widget build(BuildContext context) {

    TextEditingController _u = TextEditingController();

    TextEditingController _p = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: LayoutWidget.primary(),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              //child: Image.asset(''),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _u,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Informe o login',
                hintStyle: TextStyle(
                  color: LayoutWidget.light(),
                  fontWeight: FontWeight.w100,
                  fontSize: 16
                )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _p,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Informe a senha',
                hintStyle: TextStyle(
                  color: LayoutWidget.light(),
                  fontWeight: FontWeight.w100,
                  fontSize: 16
                )
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              //child:SizedBox.expand()
              height: 40,
              alignment: Alignment.centerLeft,
              child: FlatButton(
                child: Text(
                  "Cadastrar Usuário",
                  textAlign: TextAlign.left,
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(LoginAddPage.tag);
                },
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                ),
                onPressed: (){},
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(height: 10,color: LayoutWidget.info(),),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xFFF58524),
                    Color(0xFFF92B7F)
                  ]
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5)
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: LayoutWidget.dark(),
                          fontSize: 16
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Icon(Icons.vpn_key),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: (){
                    LoginServices loginServices = LoginServices();
                    loginServices.validadeLogin(context, _u.text.toLowerCase(), _p.text.toLowerCase());
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 35,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xFF3C5A99),
                borderRadius: BorderRadius.all(
                  Radius.circular(5)
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Sair",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: LayoutWidget.dark(),
                          fontSize: 16
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Icon(Icons.close),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: (){
                    exit(0);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}