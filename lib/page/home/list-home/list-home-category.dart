import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc.dart';

class HomeListCategoryPage extends StatefulWidget {

  final List<Map> listCategorys;
  final String filter;
  final ListCategoryBloc listCategoryBloc;

  HomeListCategoryPage({Key key, this.listCategorys, this.filter, this.listCategoryBloc}): super();

  @override
  HomeListCategoryPageState createState() => HomeListCategoryPageState();
}

class HomeListCategoryPageState extends State<HomeListCategoryPage> {

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

          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.2,
            closeOnScroll: true,
            child: ListTile(
              title: Text(item['categorys']),
              subtitle: Text('Quantidade: ${item['quantity_total']}  | | Valor: ${item['value_total']}'),
              trailing: Icon(Icons.arrow_forward_ios),
            )
          );
        } 
      );
  }
}