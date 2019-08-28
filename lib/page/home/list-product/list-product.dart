import 'package:flutter/material.dart';

import 'package:kmkshoppinglist/dao/ShopplistCategoryProductTempDao.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-product-bloc-temp.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/list-product-util.dart';

class ListProduct extends StatefulWidget {

  final List<Map> listProducts;
  final String filter;
  final ListProductBlocTemp listProductBlocTemp;

  const ListProduct({Key key, this.listProducts, this.filter, this.listProductBlocTemp}) : super(key:key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {

  ShopplistCategoryProductTempDao shopplistCategoryProductTempDao = ShopplistCategoryProductTempDao();

  @override
  Widget build(BuildContext context) {

    if (widget.listProducts.isEmpty) {
      return ListView(children: <Widget>[
        ListTile(title: Text('Nenhum registro...'))
      ]);
    }

    List<Map> filteredList = List<Map>();

    if (widget.filter.isNotEmpty) {
      for (dynamic prod in widget.listProducts) {

        // Check if theres this filter in the current item
        String name = prod['products'].toString();
        if (name.contains(widget.filter)) {
          filteredList.add(prod);
        }
      }
    } else {
      filteredList.addAll(widget.listProducts);
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
          title: Text(item['products']),
          leading: GestureDetector(
            child: Icon(
                ((checked == 1) ? Icons.check_circle : Icons.check_circle_outline),
                color: ((checked == 0) ? LayoutWidget.info() : LayoutWidget.success()),
                size: 30
            ),
            onTap: () {
              if((checked == 0)){
                shopplistCategoryProductTempDao.update({ 'checked': 1 }, item['recid']).then((bool updated) {
                  if (updated) {
                    widget.listProductBlocTemp.getList();
                    loadProductList();
                  }
                });
              } else {
                shopplistCategoryProductTempDao.update({ 'checked': 0 }, item['recid']).then((updated) {
                  if (updated) {
                     widget.listProductBlocTemp.getList();
                     loadProductList();
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