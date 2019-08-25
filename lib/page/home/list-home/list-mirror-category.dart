import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-home-category.dart';
import 'package:kmkshoppinglist/page/home/list-utils/list-category-bloc.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/utils/application.dart';

class ListMirrorCategory extends StatefulWidget {

  static final tag = 'list-mirror-category';

  final String listName = HomePage.listName;

  final GlobalKey formKey = GlobalKey();

  final ListCategoryBloc listCategoryBloc = ListCategoryBloc(HomePage.refId, HomePage.listName);

  @override
  _ListMirrorCategoryState createState() => _ListMirrorCategoryState();
}

class _ListMirrorCategoryState extends State<ListMirrorCategory> {
  String filterText = "";

  @override
  Widget build(BuildContext context) {

    widget.listCategoryBloc.getList(HomePage.refId);

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
              ]
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height - 235,
            child: StreamBuilder<List<Map>>(
              stream: widget.listCategoryBloc.lists,
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

                      return HomeListCategoryPage(
                        listCategorys: snapshot.data,
                        filter: filterText,
                        listCategoryBloc: widget.listCategoryBloc
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
            height: 80,
            child: StreamBuilder<List<Map>>(
              stream: widget.listCategoryBloc.lists,
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

                      // Recupera os itens
                      List<Map> items = snapshot.data;

                      // Total de itens
                      int qtdTotal = items.length;

                      // Total de itens marcados
                      int qtdChecked = 0;

                      // Valor total quando todos os items estiverem marcados
                      double subTotal = 0.0;

                      // Valor total de items marcados
                      double vlrTotal = 0.0;

                      for (Map item in items) {
                        double vlr = 0.00;
                        if((item['value_total'] != null 
                          && item['quantity_total'] != null)
                          && (item['value_total'] > 0
                          && item['quantity_total'] > 0))
                          vlr = currencyToFloat(item['value_total']) * item['quantity_total'];

                        subTotal += vlr;
                        
                        if (item['checked'] == 1) {
                          qtdChecked++;
                          vlrTotal += vlr;
                        }
                      }
                      bool isClosed = (subTotal == vlrTotal);  
                      return Row(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(children: <Widget>[Text('Categorias'), Text(qtdTotal.toString() ?? 0, textScaleFactor: 1.2)]),
                              Column(children: <Widget>[Text('Carrinho'), Text(qtdChecked.toString(), textScaleFactor: 1.2)]),
                              Column(children: <Widget>[Text('Faltando'), Text((qtdTotal - qtdChecked).toString(), textScaleFactor: 1.2)]),
                            ],
                          ),
                        ),
                        Container(
                          color: Color.fromRGBO(0, 0, 0, 0.04),
                          width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Sub: '+ doubleToCurrency(subTotal), style: TextStyle(
                                fontSize: 18,
                                color: LayoutWidget.dark(0.6),
                                fontWeight: FontWeight.bold
                              )),
                              SizedBox(height: 5),
                              Text('Total: '+ doubleToCurrency(vlrTotal), style: TextStyle(
                                fontSize: 22,
                                color: isClosed ? LayoutWidget.success() : LayoutWidget.info(),
                                fontWeight: FontWeight.bold
                              ))
                            ],
                          ),
                        )                        
                      ]);
                    }   
                }
              }
            ),
          ),
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
            height: 20,
            child: Center(child: Text(widget.listName, style:  TextStyle(
              fontSize: 16,
              color: LayoutWidget.primary()
            )))
          ),
        ]
      )
      
    );

    return Scaffold(
      appBar: LayoutWidget.getAppBar(ListMirrorCategory.tag, context),
      body: content,
      //floatingActionButton: LayoutWidget.activeButtom(ListMirrorCategory.tag, context)
    );
  }
}