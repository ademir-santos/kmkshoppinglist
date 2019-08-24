import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:kmkshoppinglist/dao/UserShoppingListDao.dart';
import 'package:kmkshoppinglist/page/home/home-widget.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-category.dart';
import 'package:kmkshoppinglist/utils/application.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class HomeListPage extends StatefulWidget {

  final List<Map> shoppList;

  HomeListPage({this.shoppList}): super();

  static Widget valueWidget;
  static int cont = 0;

  @override
  HomeListPageState createState() => HomeListPageState();
}

class HomeListPageState extends State<HomeListPage> {
  final create = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {

      if(widget.shoppList.length == 0){
      return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.pages),
            title: Text('Nenhuma registro...')
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
              itemCount: widget.shoppList.length,
              itemBuilder: (BuildContext context, int index) {
                Map shoppList = widget.shoppList[index];
                return  Container(child:Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  closeOnScroll: true,
                  child: Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: LayoutWidget.primary(),
                        child: Text(shoppList['list_name'].substring(0, 1).toString()),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(shoppList['list_name']),
                      subtitle: Text('Valor Total: ' + doubleToCurrency(shoppList['value_total']) + ' | | ' + create.format(DateTime.parse(shoppList['created'])).toString()),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        HomePage.listName = shoppList['list_name'];
                        HomePage.refId = shoppList['recid'];
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed(ListMirrorCategory.tag);
                      }
                    )
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Editar',
                      icon: Icons.border_color,
                      color: Colors.indigo,
                      onTap: () {
                        HomeWidget.showEditDialog(context, shoppList);
                      },
                    ),
                  ],

                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Excluir',
                      icon: Icons.delete,
                      color: Colors.red,
                      onTap: () {
                        UserShoppingListDao userShoppingListDao = UserShoppingListDao();

                        userShoppingListDao.delete(shoppList['recid']).then((deleted){
                          if(deleted) {
                            Navigator.of(context).pushReplacementNamed(HomePage.tag);
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