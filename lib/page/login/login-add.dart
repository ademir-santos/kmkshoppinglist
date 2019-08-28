import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kmkshoppinglist/dao/LoginDao.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/login/login-page.dart';

class LoginAddPage extends StatefulWidget {

  static String tag = 'login-add';

  @override
  _LoginAddPageState createState() => _LoginAddPageState();
}

class _LoginAddPageState extends State<LoginAddPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _uLogin = TextEditingController();

  final TextEditingController _uPassword = TextEditingController();

  final TextEditingController _uValidPassword = TextEditingController();

  final TextEditingController _uNameFull = TextEditingController();

  final TextEditingController _uEmail = TextEditingController();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {

    final inputLogin = TextFormField(
      controller: _uLogin,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Informe o usuário',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    final inputPassword = TextFormField(
      controller: _uPassword,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Informe a senha',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    final inputValidPassword = TextFormField(
      controller: _uValidPassword,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirme a senha',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    final inputNameFull = TextFormField(
      controller: _uNameFull,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Informe seu nome',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    final inputEmail = TextFormField(
      controller: _uEmail,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Informe e-mail',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Cadastro de usuário'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Divider(height: 50, color: LayoutWidget.dark(),),
              SizedBox(height: 30),
              inputLogin,
              SizedBox(height: 30),
              inputPassword,
              SizedBox(height: 30),
              inputValidPassword,
              SizedBox(height: 30,),
              inputNameFull,
              SizedBox(height: 30),
              inputEmail,
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    activeColor: LayoutWidget.primary(),
                    onChanged: (bool value) {
                      setState(() {
                        this.isSelected = value;
                      });
                    },
                    value: this.isSelected,
                  ),
                  GestureDetector(
                    child: Text('Usuário ativo?', style: TextStyle(fontSize: 18)),
                    onTap: () {
                      setState(() {
                        this.isSelected = !this.isSelected;
                      });
                    },
                  )
                ]
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                RaisedButton(
                  color: LayoutWidget.secondary(),
                  child: Text('Cancelar', style:TextStyle(color: LayoutWidget.light())),
                  padding: EdgeInsets.only(left: 50, right: 50),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                RaisedButton(
                  color: LayoutWidget.primary(),
                  child: Text('Salvar', style:TextStyle(color: LayoutWidget.light())),
                  padding: EdgeInsets.only(left: 50, right: 50),
                  onPressed: () {

                    if(_uPassword.text == _uValidPassword.text) {
                      
                    // Instancia model
                      LoginDao loginDao = LoginDao();

                      // Adiciona no banco de dados
                      loginDao.insert({
                        'users': _uLogin.text.toLowerCase(),
                        'password': _uPassword.text.toLowerCase(),
                        'name': _uNameFull.text,
                        'email': _uEmail.text.toLowerCase(),
                        'active': this.isSelected
                      }).then((saved) {
                        Navigator.of(context).pop();
                        Navigator.of(context).maybePop(LoginPage);
                      });
                    } else  {

                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Informação de alerta!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('O campo senha de ser igual ao confirmar senha!'),
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
                  },
                )
              ])
            ]
           )
         )
       )
    );
  }
}