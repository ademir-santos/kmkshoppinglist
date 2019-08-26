import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/dao/ShoppingListCategoryDao.dart';
import 'package:kmkshoppinglist/dao/ShoppingListCategoryTempDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-category.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-product.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class ListHomeCategory extends StatefulWidget {

  static String categoryName;
  static int refIdCategory;

  final List<Map> listCategorys;
  final String filter;
  final ListCategoryBloc listCategoryBloc;

  ListHomeCategory({Key key, this.listCategorys, this.filter, this.listCategoryBloc}): super(key:key);

  @override
  ListHomeCategoryState createState() => ListHomeCategoryState();
}

class ListHomeCategoryState extends State<ListHomeCategory> {

  @override
  Widget build(BuildContext context){
    
    if (widget.listCategorys.isEmpty) {
      return ListView(children: <Widget>[
        ListTile(title: Text('Nenhum registro...'))
      ]);
    }

    List<Map> filteredList = List<Map>();

    if (widget.filter.isNotEmpty) {
      for (dynamic cat in widget.listCategorys) {

        // Check if theres this filter in the current item
        String name = cat['categorys'].toString();
        if (name.contains(widget.filter)) {
          filteredList.add(cat);
        }
      }
    } else {
      filteredList.addAll(widget.listCategorys);
    }

    if (filteredList.isEmpty) {
      return ListView(children: <Widget>[
        ListTile(title: Text('Nenhum registro encontrado...'))
      ]);
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int i) {
        
        Map item = filteredList[i];

        int qtyTotal = item['quantity_total'];

        return Container(
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            closeOnScroll: true,
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: LayoutWidget.primary(),
                  child: Text(item['categorys'].substring(0, 1).toString()),
                  foregroundColor: Colors.white,
                ),
                title: Text(item['categorys']),
                subtitle: Text('Quantidade: $qtyTotal  | | Valor: ${item['value_total']}'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  ListHomeCategory.categoryName = item['categorys'];
                  ListMirrorProductPage.refIdCategory = item['recid'];
                  ListMirrorProductPage.categoryName = item['categorys'];
                  ListHomeCategory.refIdCategory = item['recid'];
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(ListMirrorProductPage.tag);
                }
              )
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Excluir',
                icon: Icons.delete,
                color: Colors.red,
                onTap: () {
                  ShoppingListCategoryDao shoppingListCategoryDao = ShoppingListCategoryDao();
                  String cat = item['categorys'];

                  shoppingListCategoryDao.delete(item['recid']).then((deleted){
                    if(deleted) {
                      ShoppingListCategoryTempDao shoppingListCategoryTempDao = ShoppingListCategoryTempDao();
                      shoppingListCategoryTempDao.updateSelectedCategory(HomePage.refId, cat, 0).then((update){
                        Navigator.of(context).pushReplacementNamed(ListMirrorCategoryPage.tag);
                      });
                    }
                  });
                }
              )
            ]
          )
        );
      } 
    );
  }
}