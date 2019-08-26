
import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-add.dart';
import 'package:kmkshoppinglist/page/login/login-services.dart';

class LoginPage extends StatefulWidget {

  static String tag = 'login-page';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _uLogin = TextEditingController();

  final TextEditingController _uPassword = TextEditingController();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    final inputLogin = TextFormField(
      controller: widget._uLogin,
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
      controller: widget._uPassword,
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
      body: Container(
        color:  Color.fromRGBO(184, 202, 212, 0.8),
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
          bottom: 150
        ),
        child: Form(
          key: widget._formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                //child: Image.asset(''),
              ),
              SizedBox(height: 20),
              inputLogin,
              SizedBox(height: 30),
              inputPassword,
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 300,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 150,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(child: Text("Cadastrar Usuário", textAlign: TextAlign.center),
                            onPressed: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(LoginAddPage.tag);
                            }
                          ),
                        ]
                      )
                    ),                    
                  ]
                )
              ),
              SizedBox(height: 50),
              Divider(height: 10,color: LayoutWidget.primary(),),
              SizedBox(height: 20),
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromRGBO(119, 136, 153, 0.8),
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
                      loginServices.validadeLogin(context, widget._uLogin.text.toLowerCase(), widget._uPassword.text.toLowerCase());
                    },
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