import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/models/ShoppingListCategoryModel.dart';
import 'package:kmkshoppinglist/models/ShoppingListCategoryTempModel.dart';
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
  
  ShoppingListCategoryTempModel shoppingListCategoryTempModel = ShoppingListCategoryTempModel();
  @override
  Widget build(BuildContext context) {
    ShoppingListCategoryModel shoppingListCategoryModel = ShoppingListCategoryModel();

    if (widget.listCategorys.isEmpty) {
      return ListView(children: <Widget>[
        ListTile(title: Text('Nenhum registro...'))
      ]);
    }
    
    List<Map> filteredList = List<Map>();

    /*shoppingListCategoryModel.list(HomePage.refId).then((listShop) {
      listShop.addAll(listShop.asMap().);
    });*/

    widget.listCategoryBlocTemp.getList();

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
        int checked = item['checked'];
        //listSh =  listShop[i].length == 0? Map() : listShop[i];     

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
                ((checked == 1) ? Icons.check_box : Icons.check_box_outline_blank),
                color: ((checked == 0) ? LayoutWidget.info() : LayoutWidget.success()),
                size: 42
              ),
              onTap: () {
                checked = item['checked'];
                if((checked == 0)){
                    int recid = item['recid'];
                    shoppingListCategoryTempModel.update({ 'checked': 1 }, recid).then((bool updated) {
                    if (updated) {
                      widget.listCategoryBlocTemp.getList();
                    }
                  });
                }
                else
                {
                  int recid = item['recid'];
                  shoppingListCategoryTempModel.update({ 'checked': 0 }, recid).then((updated) {
                    if (updated) {
                      widget.listCategoryBlocTemp.getList();
                    }
                  });
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
