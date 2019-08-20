import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmkshoppinglist/models/ProductModel.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/product/product-widget.dart';
import 'package:kmkshoppinglist/page/product/product.dart';

class ProductListPage extends StatefulWidget {

  final List<Map> product;

  ProductListPage({this.product}): super();

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  List<Widget> value = List<Widget>();
  ProductModel productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    /*
    if(widget.product.length == 0){
      return ListView(
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.pages),
              title: Text('Nenhum produto cadastrada ainda...')
          ),
        ],
      );
    }
    */

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
                      hintText: 'Pesquisar produto',
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
                        ProductWidget.getAction(context);
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
              itemCount: widget.product.length,
              itemBuilder: (BuildContext context, int index) {
                Map product = widget.product[index];
                return  Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  closeOnScroll: true,
                  child: Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: LayoutWidget.primary(),
                        child: Text(product['products'].substring(0, 1).toString()),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(product['products']),
                      subtitle: Text('Marca: '+ product['brand'] +' | ' + 'UN Medida: '+ product['unit_measurement']),
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
                          ProductWidget.showEditDialog(context, product);
                        },
                      ),
                    ],

                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Excluir',
                        icon: Icons.delete,
                        color: Colors.red,
                        onTap: () {
                          productModel.delete(product['recid']).then((deleted){
                            if(deleted) {
                              Navigator.of(context).pushReplacementNamed(ProductPage.tag);
                            }
                          });
                        },
                      ),
                    ]
                );
              }
            )
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(100, 150, 255, 0.3),
                  Color.fromRGBO(255, 150, 240, 0.3)
                ]
              )
            ),
            width: MediaQuery.of(context).size.width,
            //color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(left: 15, top: 10),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[

                Text(CategoryPage.categorys.toUpperCase(), style: TextStyle( fontSize: 16,
                  color: LayoutWidget.info())
                )
              ]
            )
          )
        ],
      ),
    );
  }
}
