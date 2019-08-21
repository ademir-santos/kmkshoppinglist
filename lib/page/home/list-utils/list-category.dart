import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/models/ShoppingListCategoryModel.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc-temp.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-widget.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/list-Category-util.dart';

class ListCategoryPage extends StatefulWidget {

  final List<Map> listCategorys;
  final String filter;
  final ListCategoryBlocTemp listCategoryBloc;

  const ListCategoryPage({Key key, this.listCategorys, this.filter, this.listCategoryBloc}) : super(key: key);

  @override
  ListCategoryPageState createState() => ListCategoryPageState();
}

class ListCategoryPageState extends State<ListCategoryPage> {
  
  @override
  Widget build(BuildContext context) {
    ShoppingListCategoryModel shoppingListCategoryModel = ShoppingListCategoryModel();
    //shoppingListCategoryModel.list(HomePage.refId);

    if (widget.listCategorys.isEmpty) {
      return ListView(children: <Widget>[
        ListTile(title: Text('Nenhum registro...'))
      ]);
    }
    
    List<Map> filteredList = List<Map>();
    List<Map> listShop = List<Map>();

    /*shoppingListCategoryModel.list(HomePage.refId).then((listShop) {
      listShop.addAll(listShop.asMap().);
    });*/

    widget.listCategoryBloc.getList();

    //for(Map m in shoppingListCategoryModel.list(HomePage.refId))

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
        Map listSh = Map();
        //listSh =  listShop[i].length == 0? Map() : listShop[i];

        shoppingListCategoryModel.list(HomePage.refId).then((listShop) {
          listSh.addAll(listShop.asMap());
        });
        

        /*String itemUnit = unity.keys.first;
        unity.forEach((name, precision) {
          if (precision == item['precisao']) {
            itemUnit = name;
          }
        });*/

        //double valueTota = currencyToDouble(item['value_total']) == 0 ?? 0.00;
        //String vlTotal = doubleToCurrency(realVal * item['quantity_total']);

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.2,
          closeOnScroll: true,
          child: ListTile(
            leading: GestureDetector(
              child: Icon(
                ((listSh['checked'] == 1) ? Icons.check_box : Icons.check_box_outline_blank),
                color: ((listSh['checked'] == 0) ? LayoutWidget.info() : LayoutWidget.success()),
                size: 42
              ),
              onTap: () {
                ListCategoryWidget listCategoryWidget = ListCategoryWidget();

                if((listSh['checked'] == 1)){

                    shoppingListCategoryModel.update({ 'checked': !(listSh['checked'] == 1) }, listSh['recid']).then((bool updated) {
                    if (updated) {
                      widget.listCategoryBloc.getList();
                    }
                  });
                }
                else
                {
                  setcategoryList(HomePage.refId, HomePage.listName, item);
                  //ListCategoryWidget listNew = ListCategoryWidget();

                  //widget.listShopBloc.setValue();

                  /*shoppingListCategoryModel.insert({
                    'refid_shopplist': HomePage.refId,
                    'list_name': HomePage.listName,
                    'refid_category': item['recid'],
                    'category': item['categorys'],
                    'checked': 1,
                    'created': DateTime.now().toString()
                  }).then((recid){
                    Navigator.of(context).pop();
                    Navigator.of(context).popAndPushNamed(ListMirrorCategory.tag);
                  });*/
                  /*if (updated) {
                      widget.listBloc.getList();
                    }*/
                }
                
              },
            ),
            title: Text(item['categorys']),
            subtitle: Text('Quantidade: ${item['quantity_total']}  | | Valor: ${item['value_total']}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              shoppingListCategoryModel.getItem(item['recid']).then((Map i) {

                // Adiciona dados do item a pagina
                //ItemEditPage.item = i;

                // Abre a pagina
                //Navigator.of(context).pushNamed(ItemEditPage.tag);
              });
            },
          ),
          /*secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Deletar',
              icon: Icons.delete,
              color: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: Text('Tem certeza?'),
                      content: Text('Esta ação irá remover o item selecionado e não poderá ser desfeita'),
                      actions: <Widget>[
                        RaisedButton(
                          color: LayoutWidget.secondary(),
                          child: Text('Cancelar', style: TextStyle(color: LayoutWidget.light())),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                        RaisedButton(
                          color: LayoutWidget.danger(),
                          child: Text('Remover', style: TextStyle(color: LayoutWidget.light())),
                          onPressed: () {
                            shoppingListCategoryModel.delete(item['pk_item']);

                            Navigator.of(ctx).pop();
                            widget.listBloc.getList();
                          }
                        )
                      ],
                    );
                  }
                );
              },
            )
          ],*/
        );
      }
    );
  }
}
