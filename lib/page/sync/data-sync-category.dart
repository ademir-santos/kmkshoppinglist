import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-list-bloc.dart';
import 'package:kmkshoppinglist/page/category/category-list.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

class DataSyncCaTegoryPage extends StatefulWidget {

  static final tag = 'data-sync-category-page';

  @override
  _DataSyncCaTegoryPageState createState() => _DataSyncCaTegoryPageState();
}

class _DataSyncCaTegoryPageState extends State<DataSyncCaTegoryPage> {
  
  CategoryListBloc listCategoryBloc = CategoryListBloc();

  String filterText = "";

  @override
  void dispose() {
    listCategoryBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    listCategoryBloc.getList();

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
                      filterText = text;
                    },
                  ),
                ),
              ]
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height - 235,
            child: StreamBuilder<List<Map>>(
              stream: listCategoryBloc.lists,
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

                      return CategoryListPage(category: snapshot.data);
                    }
                }
              },
            ),
          ),

        ]
      )
    );

    return Layout.getContent(context, content, false, DataSyncCaTegoryPage.tag);
  }
}