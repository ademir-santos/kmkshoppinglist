import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

class HomePage extends StatefulWidget{
  static String tag = 'home-page';

  HomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override   
  Widget build(BuildContext context) {

    Widget content = ListView.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int pos) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigoAccent,
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

    return Layout.getContent(context, content);
  }
}