import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/json-class/login/login-json.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';

class SynchronizeToken extends StatefulWidget {

  static final tag = 'synchronize-token';

  static String page = '';

  final LoginModelJson loginJson = staticLoginJson;

  SynchronizeToken() : super();

  @override
  _SynchronizeTokenState createState() => _SynchronizeTokenState();
}

class _SynchronizeTokenState extends State<SynchronizeToken> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.black,
      key: scaffoldKey,
      body: Center(
        child: FutureBuilder<LoginModelJson>(
          future: fetchPostLogin(widget.loginJson),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none: 
              case ConnectionState.waiting: 
                return CircularProgressIndicator();
                break;
              default:
                if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                } else {
                  switch (SynchronizeToken.page) {
                      case 'category-alert-dialog':
                          Navigator.canPop(context);
                          //Navigator.of(context).popAndPushNamed(SynchronizeCategoryCircularProgress.tag);                        
                        break;
                      default:
                    }
                }
                break;
            }
          },
        )
      )
    );

  }
}