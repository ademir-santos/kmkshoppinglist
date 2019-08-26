import 'package:flutter/material.dart';
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

  final TextEditingController _uNameFull = TextEditingController();

  final TextEditingController _uEmail = TextEditingController();

  final TextEditingController _uChecked = TextEditingController();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {

    final inputLogin = TextFormField(
      controller: _uLogin,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Informe usuário',
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
        hintText: 'Informe senha',
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
        hintText: 'Informe nome',
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
              Text(
                'Adicionar Item',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
                ),
              ),
              SizedBox(height: 10),
              Text('Informe usuário'),
              inputLogin,
              SizedBox(height: 10),
              Text('Informe a Senha'),
              inputPassword,
              SizedBox(height: 10),
              Text('Informe o nome completo'),
              inputNameFull,
              SizedBox(height: 10),
              Text('Informe o e-mail'),
              inputEmail,
              SizedBox(height: 10),
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
                      Navigator.of(context).pushReplacementNamed(LoginPage.tag);
                    });
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