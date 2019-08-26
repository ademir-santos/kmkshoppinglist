import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-product.dart';
import 'package:kmkshoppinglist/page/home/list-product/list-product.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-product-bloc-temp.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/product/product-list-bloc.dart';
import 'package:kmkshoppinglist/utils/list-product-util.dart';

class MirroProductPage extends StatefulWidget {

  static final tag = 'mirror-product';

  final String categoryName = ListMirrorProductPage.categoryName;

  String filterText = "";

  final ListProductBlocTemp listProductBlocTemp = ListProductBlocTemp();
  final ProductListBloc productListBloc = ProductListBloc(ListMirrorProductPage.categoryName);

  @override
  _MirroProductPageState createState() => _MirroProductPageState();
}

class _MirroProductPageState extends State<MirroProductPage> {

  @override
  void dispose() {
    widget.listProductBlocTemp.dipose();
    widget.productListBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    loadProductListTemp(widget.productListBloc.lists);

    widget.listProductBlocTemp.getList(HomePage.refId, ListMirrorProductPage.categoryName);

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
                      setState(() {
                        widget.filterText = text.toUpperCase();
                      });
                    },
                  ),
                ),
              ]
            )
          ),

          Container(
            height: MediaQuery.of(context).size.height - 180,
            child: StreamBuilder<List<Map>>(
              stream: widget.listProductBlocTemp.lists,
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

                      return ListProduct(
                        listProducts: snapshot.data,
                        filter: widget.filterText,
                        listProductBlocTemp: widget.listProductBlocTemp
                      );

                    }
                }
              },
            ),
          ),
          
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
            height: 50,
            child: Center(child: Text(widget.categoryName, style:  TextStyle(
              fontSize: 16,
              color: LayoutWidget.primary(),
              fontWeight: FontWeight.bold
            )))
          )]
      )
    );

    return Scaffold(
      appBar: LayoutWidget.getAppBar(MirroProductPage.tag, context),
      body: content
    );
  }
}