import 'package:flutter/material.dart';

import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-category/list-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-base.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class MirrorCategoryPage extends StatefulWidget {
  
  static final tag = 'mirror-category';
  final int refIdList = HomePage.refId;
  final String listName = HomePage.listName;

   @override
  _MirrorCategoryPageState createState() => _MirrorCategoryPageState();
}

class _MirrorCategoryPageState extends State<MirrorCategoryPage> {
  
  String filterText = "";

  final ListCategoryBlocTemp listCategoryBlocTemp = new ListCategoryBlocTemp();

  @override
  void dispose() {
    listCategoryBlocTemp.dipose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    LayoutBase.appBarBase(MirrorCategoryPage.tag, context);

    listCategoryBlocTemp.getList();
    
    final content = SingleChildScrollView(
      child: Column(
        children: <Widget> [
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Pesquisar',
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        filterText = text.toUpperCase();
                      });
                    },
                  ),
                ),
              ]
            )
          ),

          Container(
            height: MediaQuery.of(context).size.height - 180,
            child: StreamBuilder<List<Map>>(
              stream: listCategoryBlocTemp.lists,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: Text('Carregando...'));
                    break; // Useless after return
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                    } else {

                      return ListCategory(
                        listCategorys: snapshot.data,
                        filter: filterText,
                        listCategoryBlocTemp: listCategoryBlocTemp
                      );
                    }
                }
              },
            ),
          ),
          
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(100, 150, 255, 0.3),
                  Color.fromRGBO(255, 150, 240, 0.3)
                ]
              ),
            ),
            height: 50,
            child: Center(child: Text(widget.listName, style:  TextStyle(
              fontSize: 16,
              color: LayoutWidget.primary(),
              fontWeight: FontWeight.bold
            )))
          )]
      )
    );

    return Scaffold(
      appBar: LayoutBase.appBar,
      body: content
    );
  }
}