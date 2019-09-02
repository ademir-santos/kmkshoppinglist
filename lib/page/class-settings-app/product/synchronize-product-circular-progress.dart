import 'package:flutter/material.dart';

import 'package:kmkshoppinglist/json-class/variable-json.dart';
import 'package:kmkshoppinglist/page/class-settings-app/app-load-property/sync-body-page.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';
import 'package:kmkshoppinglist/page/product/product.dart';

import 'synchronize-product-block.dart';

class SynchronizeProductCircularProgress extends StatefulWidget {

  static final tag = 'synchronize-product-circular-progress';

  final loginJson = staticLoginJson;

  final SynchronizeProductBlock synchronizeBloc = new SynchronizeProductBlock(staticLoginJson);

  final CircularProgressIndicator progress = new CircularProgressIndicator();
  
  @override
  _SynchronizeProductCircularProgressState createState() => _SynchronizeProductCircularProgressState();
}

class _SynchronizeProductCircularProgressState extends State<SynchronizeProductCircularProgress> {
  
  @override
  void initState()
  {
    widget.progress.createState();
    super.initState();
  }

  @override
  void dispose(){
    widget.synchronizeBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    widget.synchronizeBloc.getList();

    final content = SingleChildScrollView(
      child: Column(
        children: <Widget> [ 
          Container(            
            height: MediaQuery.of(context).size.height - 150,
            color: Colors.black87,
            child: Center(
              child: StreamBuilder<List<Map>>(
                stream: widget.synchronizeBloc.lists,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: 
                    case ConnectionState.waiting: 
                      return new Center(child: new CircularProgressIndicator());
                      break;
                    default:
                      if (snapshot.hasError) {
                            print(snapshot.error);
                            return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.hasData) {
                          switch(statusJson) {
                          case 200:
                            return SyncBodyPage(stateCode:statusJson, map:snapshot.data);
                            break;
                          case 201:
                            return SyncBodyPage(stateCode:statusJson, map:snapshot.data);
                            break;
                          case 400:
                            return SyncBodyPage(stateCode:statusJson, map:snapshot.data);
                            break;
                          case 401:
                            return SyncBodyPage(stateCode:statusJson, map:snapshot.data);
                            break;
                          case 402:
                            return SyncBodyPage(stateCode:statusJson, map:snapshot.data);
                            break;
                          case 500:
                            return SyncBodyPage(stateCode:statusJson, map:snapshot.data);
                            break;
                        }
                      }
                      break;
                    }  
                  }
                }
              )
            ),
          ),

          SizedBox(height: 10),

          Container(
            color: Colors.indigo,
            height: 40,
            child:  Container(
              width: 390,
              child:
              FlatButton(
                hoverColor: Colors.red,
                color: LayoutWidget.primary(),
                child: Text('Retornar', style: TextStyle(color: LayoutWidget.light())),
                onPressed: (){
                    Navigator.of(context).pushReplacementNamed(ProductPage.tag);
                },
              ) 
            )
          )
        ]
      )
    );

    return Layout.getContent(context,content, false, SynchronizeProductCircularProgress.tag);
  }
}
