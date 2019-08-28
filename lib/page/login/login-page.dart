import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-add.dart';
import 'package:kmkshoppinglist/page/login/login-services.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _uLogin = TextEditingController();

  final TextEditingController _uPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputLogin = TextFormField(
      controller: _uLogin,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Informe usuário',
        hintStyle: TextStyle(
          color: LayoutWidget.primary(),
          fontWeight: FontWeight.w400,
          fontSize: 16
        )
      ),
    );

    final inputPassword = TextFormField(
      controller: _uPassword,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Informe senha',
        hintStyle: TextStyle(
          color: LayoutWidget.primary(),
          fontWeight: FontWeight.w400,
          fontSize: 16
        )
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(184, 202, 212, 0.8),
      body: Container(
        //color:  Color.fromRGBO(184, 202, 212, 0.8),
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
          bottom: 100
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset('images/listabuy01.png'),
              ),
              SizedBox(height: 20),
              inputLogin,
              SizedBox(height: 30),
              inputPassword,
              SizedBox(height: 60),
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromRGBO(100, 149, 237, 0.8),
                      Color.fromRGBO(72, 61, 139, 0.9)
                    ]
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8)
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
                      ]
                    ),
                    onPressed: (){
                      LoginServices loginServices = LoginServices();
                      loginServices.validadeLogin(context, _uLogin.text.toLowerCase(), _uPassword.text.toLowerCase());
                    },
                   )
                )
              ),
              SizedBox(height: 30),
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromRGBO(95, 158, 160, 0.8),
                      Color.fromRGBO(72, 61, 139, 0.9)
                    ]
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8)
                  ),
                ),
                child: SizedBox.expand(
                   child: FlatButton(
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Cadastrar Usuário",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: LayoutWidget.dark(),
                            fontSize: 16
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Icon(Icons.account_circle),
                            height: 28,
                            width: 28,
                          ),
                        )
                      ]
                    ),
                    onPressed: (){
                      Navigator.of(context).pushNamed(LoginAddPage.tag);
                    },
                   )
                )
              ),
              SizedBox(height: 30),
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromRGBO(160, 50, 80, 0.6),
                      Color.fromRGBO(72, 61, 139, 0.9)
                    ]
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8)
                  ),
                ),
                child: SizedBox.expand(
                   child: FlatButton(
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Esqueci minha senha?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: LayoutWidget.dark(),
                            fontSize: 16
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: SizedBox(
                            child: Icon(Icons.dehaze),
                            height: 28,
                            width: 28,
                          ),
                        )
                      ]
                    ),
                    onPressed: (){},
                   )
                )
              ),
            ]
          )
        )
      )
    );
  }
}