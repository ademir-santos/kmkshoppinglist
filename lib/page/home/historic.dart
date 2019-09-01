import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/json-class/login/login-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';

class HistoricoPage extends StatefulWidget {

  static String tag = 'historic-page';

  @override
  _HistoricoPageState createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  @override
  Widget build(BuildContext context) {

    LoginModelJson json = LoginModelJson();

    json.users = 'ademir.santos';
    json.password = 'kemokr@1';
    json.email = 'ademirap.santos@outlook.com';

    return Scaffold(

      appBar: AppBar(),

        body : FutureBuilder<LoginModelJson>(

            future: LoginJson.getLoginJson(json),

            builder: (context, snapshot) {

              //callAPI();

              if(snapshot.connectionState == ConnectionState.done) {



                if(snapshot.hasError){

                  return Text("Error");

                }



                return Text('Title from Post JSON : ${snapshot.data.acessToken}');



              }

              else

                return CircularProgressIndicator();

            }

        )

    );
  }
}