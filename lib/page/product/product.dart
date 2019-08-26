import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/product/product-list-bloc.dart';
import 'package:kmkshoppinglist/page/product/product-list.dart';

class ProductPage extends StatefulWidget {

  static final tag = 'product-page';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductListBloc listBloc = ProductListBloc(CategoryPage.categorys);

  @override
  void dispose() {
    listBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = StreamBuilder<List<Map>>(
      stream: listBloc.lists,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
            break;
          default:
            if(snapshot.hasError){
              print(snapshot.hasError);
              return Text('Erro: ${snapshot.error}');
            }
            else{
              return ProductListPage(product: snapshot.data);
            }
            break;
        }
      },
    );
    
    return Scaffold(
      appBar: LayoutWidget.getAppBar(ProductPage.tag, context),
      body: content
    );
  }
}