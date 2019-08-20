import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-list-bloc.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-home-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/mirror-category.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/list-Category-util.dart';

class ListMirrorCategory extends StatefulWidget {
  
  static final tag = 'list-mirror-category';

  @override
  _ListMirrorCategoryState createState() => _ListMirrorCategoryState();
}

class _ListMirrorCategoryState extends State<ListMirrorCategory> {

  ListCategoryBlocTemp listBloc = ListCategoryBlocTemp();
  CategoryListBloc listBlocCategory = CategoryListBloc();
  
  

  @override
  Widget build(BuildContext context) {

    listBlocCategory.getList();
    listBloc.getList();
    loadCategoryList(listBlocCategory.getList());

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
                return HomeListCategoryPage(shoppListCategory: snapshot.data);
              }
              break;
          }
        },
      );   

      return Scaffold(
        appBar: LayoutWidget.getAppBar(ListMirrorCategory.tag),
        body: content,
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            MirrorCategory.listName = HomePage.listName;
            MirrorCategory.refIdList = HomePage.refId;
            Navigator.of(context).pushNamed(MirrorCategory.tag);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
      ); 
  }
}