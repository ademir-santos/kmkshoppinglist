
import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-home-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/list-Category-util.dart';

class ListMirrorCategory extends StatelessWidget {

  static final tag = 'list-mirror-category';
  final GlobalKey formKey = GlobalKey();
  final listName = HomePage.listName;
  final ListCategoryBloc listBloc = ListCategoryBloc(HomePage.refId, HomePage.listName);
  final ListCategoryBlocTemp listBlocTemp = ListCategoryBlocTemp();
  String filterText = "";
  
  @override
  Widget build(BuildContext context) {

    listBlocTemp.getList();

    loadCategoryList(listBlocTemp.lists);

    listBloc.getList(HomePage.refId);

    final content = SingleChildScrollView(
      child: Column(
        children: <Widget> [
                    Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text('Lista: ' + listName ?? listBloc.getListName(), style: TextStyle(
              fontSize: 16,
              color: LayoutWidget.primary()
            )),
          ),
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
            height: MediaQuery.of(context).size.height - 249,
            child: StreamBuilder<List<Map>>(
              stream: listBloc.lists,
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

                      return HomeListCategoryPage(
                        listCategorys: snapshot.data,
                        filter: filterText,
                        listCategoryBloc: listBloc
                      );
                    }
                }
              },
            ),
          ),
        ]
      )
      
    );

    return Scaffold(
      appBar: LayoutWidget.getAppBar(ListMirrorCategory.tag, context),
      body: content,
      floatingActionButton: LayoutWidget.activeButtom(ListMirrorCategory.tag, context)
    );
  }
}