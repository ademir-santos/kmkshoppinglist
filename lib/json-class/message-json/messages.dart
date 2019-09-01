import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

code200(context, page) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'SINCRONIZAÇÃO | 200', 
          style: TextStyle(
            fontSize: 15,
            color: LayoutWidget.primary() ,
            fontWeight: FontWeight.bold)
          ) ,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('O recurso solicitado foi processado e retornado com sucesso.',
              style: TextStyle(
              fontSize: 12,
              color: LayoutWidget.success() ,
              fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(page);
            },
          ),
        ],
      );
    },
  );
}

code201(context, page) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'SINCRONIZAÇÃO | 201', 
          style: TextStyle(
            fontSize: 15,
            color: LayoutWidget.primary() ,
            fontWeight: FontWeight.bold)
          ) ,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('O recurso informado foi criado com sucesso.',
              style: TextStyle(
              fontSize: 12,
              color: LayoutWidget.success() ,
              fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(page);
            },
          ),
        ],
      );
    },
  );
}

code400(context, page) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'SINCRONIZAÇÃO | 400', 
          style: TextStyle(
            fontSize: 15,
            color: LayoutWidget.primary() ,
            fontWeight: FontWeight.bold)
          ) ,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Não foi possível interpretar a requisição. Verifique a sintaxe das informações enviadas.',
              style: TextStyle(
              fontSize: 12,
              color: LayoutWidget.danger() ,
              fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(page);
            },
          ),
        ],
      );
    },
  );
}

code401(context, page) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'SINCRONIZAÇÃO | 401', 
          style: TextStyle(
            fontSize: 15,
            color: LayoutWidget.primary() ,
            fontWeight: FontWeight.bold)
          ) ,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('A chave da API está desativada, incorreta ou não foi informada corretamente.',
              style: TextStyle(
              fontSize: 12,
              color: LayoutWidget.warning() ,
              fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(page);
            },
          ),
        ],
      );
    },
  );
}

code402(context, page) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'SINCRONIZAÇÃO | 402', 
          style: TextStyle(
            fontSize: 15,
            color: LayoutWidget.primary() ,
            fontWeight: FontWeight.bold)
          ) ,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('A chave da API está correta, porém a conta foi bloqueada por inadimplência.',
              style: TextStyle(
              fontSize: 12,
              color: LayoutWidget.danger() ,
              fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(page);
            },
          ),
        ],
      );
    },
  );
}

code403() {
  
}

code422() {
  
}

code429() {
  
}

code500(context, page) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'SINCRONIZAÇÃO | 500', 
          style: TextStyle(
            fontSize: 15,
            color: LayoutWidget.primary() ,
            fontWeight: FontWeight.bold)
          ) ,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Ocorreu uma falha na plataforma Vindi. Por favor, entre em contato com o atendimento',
              style: TextStyle(
              fontSize: 12,
              color: LayoutWidget.danger() ,
              fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(page);
            },
          ),
        ],
      );
    },
  );
}