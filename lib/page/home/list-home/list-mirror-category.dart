import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-home-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/list-Category-util.dart';

class ListMirrorCategory extends StatefulWidget {
  
  static final tag = 'list-mirror-category';
  final GlobalKey formKey = GlobalKey();

  @override
  _ListMirrorCategoryState createState() => _ListMirrorCategoryState();
}

class _ListMirrorCategoryState extends State<ListMirrorCategory> {

  String filterText = "";

  ListCategoryBloc listBloc = new ListCategoryBloc(HomePage.refId, HomePage.listName);
  ListCategoryBlocTemp listBlocTemp = new ListCategoryBlocTemp();
  
  

  @override
  Widget build(BuildContext context) {

    listBlocTemp.getList();

    loadCategoryList(listBlocTemp.lists);

    listBloc.getList(HomePage.refId);

    listBlocTemp.getList();

    final content = SingleChildScrollView(
      child: Column(
        children: <Widget> [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text('Lista: ' + listBloc.getListName(), style: TextStyle(
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
                        filterText = text;
                      });
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
    /*StreamBuilder<List<Map>>(
        stream: listBloc.lists,
        builder: (BuildContext ctx, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
              break;
            default:
              if(snapshot.hasError){
                print(snapshot.hasError);
                return Text('Erro: ${snapshot.error}');
              }
              else{
                return HomeListCategoryPage(shoppListCategory: snapshot.data);
              }
              break;
          }
        },
      );  */ 

    return Scaffold(
      appBar: LayoutWidget.getAppBar(ListMirrorCategory.tag),
      body: content,
      floatingActionButton: LayoutWidget.activeButtom(ListMirrorCategory.tag, context)
    );
  }
}