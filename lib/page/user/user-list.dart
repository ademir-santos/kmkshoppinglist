import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/models/UserModel.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/user/user-widget.dart';
import 'package:kmkshoppinglist/page/user/user.dart';

class UserListPage extends StatefulWidget {
  final List<Map> user;

  UserListPage({this.user}): super();
  
  @override
  UserListPageState createState() => UserListPageState();
}

class UserListPageState extends State<UserListPage> {
  
  List<Widget> value = List<Widget>();
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Pesquisar usuário',
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: LayoutWidget.info(),
                    onPressed: (){
                      setState(() {
                        UserWidget.getAction(context);
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 185,
            child: ListView.builder (
              shrinkWrap: true,
              itemCount: widget.user.length,
              itemBuilder: (BuildContext ctx, int index) {
                Map user = widget.user[index];
                return  Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  closeOnScroll: true,
                  child: Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: LayoutWidget.primary(),
                        child: Text(user['name'].substring(0, 1).toString()),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(user['name']),
                      subtitle: Text('Usuário: '+ user['users']),
                      selected: true,
                      
                      //: Text('Unidade de medida: '+ product['unit_measurement']),
                      trailing: Icon(Icons.arrow_forward_ios),
                    )
                  ),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Editar',
                        icon: Icons.border_color,
                        color: Colors.indigo,
                        onTap: () {
                          UserWidget.showEditDialog(ctx, user);
                        },
                      ),
                    ],

                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Excluir',
                        icon: Icons.delete,
                        color: Colors.red,
                        onTap: () {
                          userModel.delete(user['recid']).then((deleted){
                            if(deleted) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(UserPage.tag);
                            }
                          });
                        },
                      ),
                    ]
                );
              }
            )
          )
        ],
      ),
    );
  }
}