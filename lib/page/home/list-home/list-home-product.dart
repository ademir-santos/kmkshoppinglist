import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-product-bloc.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-product-widget.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/application.dart';

class ListHomeProduct extends StatefulWidget {

  final List<Map> listProducts;
  final String filter;
  final ListProductBloc listProductBloc;

  ListHomeProduct({Key key, this.listProducts, this.filter, this.listProductBloc}): super(key:key);

  @override
  _ListHomeProductState createState() => _ListHomeProductState();
}

class _ListHomeProductState extends State<ListHomeProduct> {
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

        int qtyTotal = item['quantity_total'];
        double vlUnit = double.parse(item['value_unitary'].toString());
        double vlTotal = double.parse(item['value_total'].toString());;

        return Container(
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            closeOnScroll: true,
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: LayoutWidget.primary(),
                  child: Text(item['products'].substring(0, 1).toString()),
                  foregroundColor: Colors.white,
                ),
                title: Text(item['products']),
                subtitle: Text('Qt: $qtyTotal  | |  Valor: ' + doubleToCurrency(vlUnit) + '  | |  Total: ' + doubleToCurrency(vlTotal)),
                trailing: Icon(Icons.arrow_forward_ios),
              )
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                icon: Icons.border_color,
                color: Colors.indigo,
                onTap: () {
                  ListProductWidget.showEditDialog(context, item);
                },
              ),
            ],

            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Excluir',
                icon: Icons.delete,
                color: Colors.red,
                onTap: () {

                }
              )
            ]
          )
        );
      }
    );
  }
}