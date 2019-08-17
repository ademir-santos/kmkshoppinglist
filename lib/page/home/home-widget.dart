import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/page/home/home-list.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class HomeWidget extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {
    return null;
  }

  static void getShoppList() {

    Widget value = ListView.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int pos) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white70,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: LayoutWidget.primary(),
                child: Text('$pos'),
                foregroundColor: Colors.white,
              ),
              title: Text('Tile n°$pos'),
              subtitle: Text('Informações de produto'),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Arquivar',
              icon: Icons.archive,
              color: Colors.amberAccent,
              onTap: (){ print('Arquivar'); },
            ),

            IconSlideAction(
              caption: 'Compartilhar',
              icon: Icons.share,
              color: Colors.indigo,
              onTap: (){ print('Arquivar'); },
            ),
          ],

          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Mais',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () { print('Mais'); },
            ),
            IconSlideAction(
              caption: 'Excluir',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () { print('Excluir'); },
            ),
          ],
        ); 
      },
    );

    HomeListPage.shoppList.add(value);
  }
}