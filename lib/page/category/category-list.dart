import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/dao/CategoryDao.dart';
import 'package:kmkshoppinglist/page/category/category-widget.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/product/product.dart';

class CategoryListPage extends StatefulWidget {

  final List<Map> category;

  CategoryListPage({this.category}): super();

  @override
  CategoryListPageState createState() => CategoryListPageState();         
}

class CategoryListPageState extends State<CategoryListPage> {
  List<Widget> value = List<Widget>();
  CategoryDao categoryDao = CategoryDao();

  @override
  Widget build(BuildContext context){

    if(widget.category.length == 0){
      return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.pages),
            title: Text('Nenhuma categoria cadastrada ainda...')
          )
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.height,
            child:
            ListView.builder (
              shrinkWrap: true,
              itemCount: widget.category.length,
              itemBuilder: (BuildContext context, int index) {
                Map category = widget.category[index];
                return  Container(child:Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  closeOnScroll: true,
                  child: Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: LayoutWidget.primary(),
                        child: Text(category['categorys'].substring(0, 1).toString()),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(category['categorys']),
                      subtitle: Text('Produtos vinculados 76'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        CategoryPage.recId = category['recid'];
                        CategoryPage.categorys = category['categorys'];
                        Navigator.of(context).pushNamed(ProductPage.tag);
                      }
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Editar',
                      icon: Icons.border_color,
                      color: Colors.indigo,
                      onTap: () {
                        CategoryWidget.showEditDialog(context, category);
                      },
                    ),
                  ],

                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Excluir',
                      icon: Icons.delete,
                      color: Colors.red,
                      onTap: () {
                        categoryDao.delete(category['recid']).then((deleted){
                          if(deleted) {
                            Navigator.of(context).pushReplacementNamed(CategoryPage.tag);
                          }
                        });
                      },
                    ),
                  ]
                ),
                );
              },
            )
          )
        ]
      )
    );
  }
}