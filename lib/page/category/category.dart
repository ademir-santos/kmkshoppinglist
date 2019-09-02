import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-list-bloc.dart';
import 'package:kmkshoppinglist/page/category/category-list.dart';
import 'package:kmkshoppinglist/page/category/category-widget.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

class CategoryPage extends StatefulWidget {

  static final tag = 'category-page';

  static int recId = 0;
  static String categorys = "";

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

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
                SizedBox(width: 10),
                SizedBox(
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: LayoutWidget.info(),
                    onPressed: (){
                      setState(() {
                        CategoryWidget.getAction(context);
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                )
              ]
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height - 220,
            child: StreamBuilder<List<Map>>(
              stream: listCategoryBloc.lists,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
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
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(100, 150, 255, 0.3),
                  Color.fromRGBO(255, 150, 240, 0.3)
                ]
              ),
            ),
            height: 40,
            child:  Container(
              width: 390,
              child:
              FlatButton(
                hoverColor: Colors.red,
                color: LayoutWidget.primary(),
                child: Text('Sinconizar Categorias', style: TextStyle(color: LayoutWidget.light())),
                onPressed: (){
                  CategoryWidget.syncAction(context);
                },
              )
            )
          )
        ]
      )
    );

    return Layout.getContent(context, content, true, CategoryPage.tag);
  }
}