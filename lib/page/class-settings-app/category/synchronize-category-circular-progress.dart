import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/json-class/category/category-json.dart';
import 'package:kmkshoppinglist/json-class/category/category-model-json.dart';
import 'package:kmkshoppinglist/json-class/message-json/messages.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/class-settings-app/app-load-property/snack-bar-load.dart';
import 'package:kmkshoppinglist/page/class-settings-app/app-load-property/sync-body-page.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

import 'synchronize-category-block.dart';

class SynchronizeCategoryCircularProgress extends StatefulWidget {

  static final tag = 'synchronize-category-circular-progress';

  GlobalKey<ScaffoldState> scaffold_state = new GlobalKey<ScaffoldState>();

  final loginJson = staticLoginJson;

  final SynchronizeCategoryBlock synchronizeBloc = new SynchronizeCategoryBlock(staticLoginJson);

  final CircularProgressIndicator progress = new CircularProgressIndicator();
  
  @override
  _SynchronizeCategoryCircularProgressState createState() => _SynchronizeCategoryCircularProgressState();
}

class _SynchronizeCategoryCircularProgressState extends State<SynchronizeCategoryCircularProgress> {
  
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
                          return SyncBodyPage(stateCode:statusJson, map:snapshot.data);
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
                  Navigator.of(context).pushReplacementNamed(CategoryPage.tag);
                },
              ) 
            )
          )
        ]
      )
    );

    return Layout.getContent(context,content, false, SynchronizeCategoryCircularProgress.tag);
  }
}
