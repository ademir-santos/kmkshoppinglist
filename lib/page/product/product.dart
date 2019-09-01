import 'package:flutter/material.dart';

import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/product/product-list-bloc.dart';
import 'package:kmkshoppinglist/page/product/product-list.dart';
import 'package:kmkshoppinglist/page/product/product-widget.dart';

class ProductPage extends StatefulWidget {

  static final tag = 'product-page';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final ProductListBloc listProductBloc = ProductListBloc(CategoryPage.categorys);

  String filterText = "";

  @override
  void dispose() {
    listProductBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final content = SingleChildScrollView(
      child: Column(
        children: <Widget> [
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Pesquisar',
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      ),
                    ),
                    onChanged: (text) {
                      filterText = text;
                    },
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
              ]
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height - 220,
            child: StreamBuilder<List<Map>>(
              stream: listProductBloc.lists,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: Text('Carregando...'));
                    break; // Useless after return
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                    } else {

                      return ProductListPage(product: snapshot.data);
                    }
                }
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(100, 150, 255, 0.3),
                  Color.fromRGBO(255, 150, 240, 0.3)
                ]
              ),
            ),
            height: 40,
            child:  Container(
              width: 390,
              child:
              FlatButton(
                hoverColor: Colors.red,
                color: LayoutWidget.primary(),
                child: Text('Sinconizar Produto', style: TextStyle(color: LayoutWidget.light())),
                onPressed: (){
                  ProductWidget.syncAction(context);
                },
              )
            )
          ),
          SizedBox(height: 5),
           Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(100, 150, 255, 0.3),
                  Color.fromRGBO(255, 150, 240, 0.3)
                ]
              ),
            ),
            height: 20,
            child: Center(child: Text(CategoryPage.categorys, style:  TextStyle(
              fontSize: 16,
              color: LayoutWidget.primary(),
              fontWeight: FontWeight.bold
            )))
          )
        ]
      )
    );

    
    return Scaffold(
      appBar: LayoutWidget.getAppBar(ProductPage.tag, context),
      body: content
    );
  }
}