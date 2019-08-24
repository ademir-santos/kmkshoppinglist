import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/dao/ShoppingListCategoryDao.dart';
import 'package:kmkshoppinglist/dao/ShoppingListCategoryTempDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class ListCategoryPage extends StatefulWidget {

  final List<Map> listCategorys;
  final String filter;
  final ListCategoryBlocTemp listCategoryBlocTemp;

  const ListCategoryPage({Key key, this.listCategorys, this.filter, this.listCategoryBlocTemp}) : super(key: key);

  @override
  ListCategoryPageState createState() => ListCategoryPageState();
}

class ListCategoryPageState extends State<ListCategoryPage> {
  
  ShoppingListCategoryTempDao shoppingListCategoryTempDao = ShoppingListCategoryTempDao();
  @override
  Widget build(BuildContext context) {

    if (widget.listCategorys.isEmpty) {
      return ListView(children: <Widget>[
        ListTile(title: Text('Nenhum registro...'))
      ]);
    }
    
    List<Map> filteredList = List<Map>();

    widget.listCategoryBlocTemp.getList(HomePage.refId);

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
        int checked = item['checked'];
        return new ListTile(
          trailing: Icon(Icons.label_important),
          title: Text(item['categorys']),
          leading: GestureDetector(
            child: Icon(
                ((checked == 1) ? Icons.check_circle : Icons.check_circle_outline),
                color: ((checked == 0) ? LayoutWidget.info() : LayoutWidget.success()),
                size: 30
            ),
            onTap: () {
              if((checked == 0)){
                shoppingListCategoryTempDao.update({ 'checked': 1 }, item['recid']).then((bool updated) {
                  if (updated) {
                    widget.listCategoryBlocTemp.getList(HomePage.refId);
                  }
                });
              } else {
                shoppingListCategoryTempDao.update({ 'checked': 0 }, item['recid']).then((updated) {
                  if (updated) {
                    widget.listCategoryBlocTemp.getList(HomePage.refId);
                  }
                });
              }
            }
          )
        );
      }      
    );
  }
}
