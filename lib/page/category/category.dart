import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-list-bloc.dart';
import 'package:kmkshoppinglist/page/category/category-list.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

class CategoryPage extends StatefulWidget {

  static final tag = 'category-page';

  static int recId = 0;
  static String categorys = "";

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  CategoryListBloc listBloc = CategoryListBloc();

  @override
  void dispose() {
    listBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    listBloc.getList();

    final content = StreamBuilder<List<Map>>(
      stream: listBloc.lists,
      builder: (BuildContext context, AsyncSnapshot snapshot){
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
              return CategoryListPage(category: snapshot.data);
            }
            break;
        }
      },
    );



    return Layout.getContent(context, content, true, CategoryPage.tag);
  }
}