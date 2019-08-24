import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-list-bloc.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-category/list-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:kmkshoppinglist/utils/list-Category-util.dart';

class MirrorCategory extends StatefulWidget {
  
  static final tag = 'mirror-category';
  static int refIdList;
  static String listName;

   @override
  _MirrorCategoryState createState() => _MirrorCategoryState();
}

class _MirrorCategoryState extends State<MirrorCategory> {

  String filterText = "";

  ListCategoryBlocTemp listCategoryBlocTemp = ListCategoryBlocTemp();
  CategoryListBloc categoryBlocList = CategoryListBloc();
  
  @override
  void dispose() {
    listCategoryBlocTemp.dipose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    categoryBlocList.getList();
    
    loadCategoryListTemp(categoryBlocList.lists);

    listCategoryBlocTemp.getList(HomePage.refId);
    
    final content = SingleChildScrollView(
      child: Column(
        children: <Widget> [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text('Lista: ' + MirrorCategory.listName, style: TextStyle(
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
            height: MediaQuery.of(context).size.height,
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

                      return ListCategoryPage(
                        listCategorys: snapshot.data,
                        filter: filterText,
                        listCategoryBlocTemp: listCategoryBlocTemp
                      );

                    }
                }
              },
            ),
          ),
        ],
      )
    );

    return Scaffold(
      appBar: LayoutWidget.getAppBar(MirrorCategory.tag, context),
      body: content
    );
  }
}