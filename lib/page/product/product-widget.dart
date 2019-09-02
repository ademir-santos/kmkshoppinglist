import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/dao/CategoryDao.dart';
import 'package:kmkshoppinglist/dao/ProductDao.dart';
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/product/product-json.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';
import 'package:kmkshoppinglist/page/category/category.dart';
import 'package:kmkshoppinglist/page/class-settings-app/product/synchronize-product-circular-progress.dart';
import 'package:kmkshoppinglist/page/home/home.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';
import 'package:kmkshoppinglist/page/product/product.dart';

class ProductWidget {

  static setCategory(BuildContext ctx, String prod, String brand,String unitmeas, int refidcat, String cat) {
    
    ProductDao productDao = ProductDao();

    String product = prod.substring(0,1).toUpperCase()+prod.substring(1);
    brand = brand.toUpperCase();
    
    productDao.insert({
      'products': product,
      'unit_measurement': unitmeas.toUpperCase(),
      'brand': brand,
      'refid_category': refidcat,
      'categorys': cat
    }).then((recId){
      CategoryDao categoryDao = CategoryDao();
      categoryDao.updateProductCount(cat);
      Navigator.of(ctx).pop();
      Navigator.of(ctx).popAndPushNamed(ProductPage.tag);
    });
  }

  static List<Widget> getAction(context) {
    TextEditingController _p = TextEditingController();
    TextEditingController _u = TextEditingController();
    TextEditingController _b = TextEditingController();
    List<Widget> items = List<Widget>();

    final Widget value = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Cadastro de produto'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _p,
                  decoration: InputDecoration(
                    hintText: 'Nome da produto',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _b,
                  decoration: InputDecoration(
                    hintText: 'Marca do produto',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _u,
                  decoration: InputDecoration(
                    hintText: 'Unidade de medida',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                setCategory(ctx, _p.text, _b.text, _u.text, CategoryPage.recId, CategoryPage.categorys);
              },
            ),

            FlatButton(
              color: LayoutWidget.danger(),
              child: Text('Cancelar', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        );
      },
    ) as Widget;

    items.add(value);

    return items;
  }

  static void showEditDialog(BuildContext context, Map product){
    TextEditingController _p = TextEditingController();
    TextEditingController _u = TextEditingController();
    TextEditingController _b = TextEditingController();

    _p.text = product['products'];
    _u.text = product['unit_measurement'];
    _b.text = product['brand'];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        final inputProd = TextFormField(
          controller: _p,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Produto',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );
        final inputBrand = TextFormField(
          controller: _b,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Marca',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );
        final inputUnit = TextFormField(
          controller: _u,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Unidade de medida',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        return AlertDialog(
          title: Text('Editar Categoria'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                inputProd,
                SizedBox(height: 15),
                inputBrand,
                SizedBox(height: 15),
                inputUnit
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                ProductDao productDao = ProductDao();
                productDao.update({
                  'products': _p.text.substring(0,1).toUpperCase()+_p.text.substring(1),
                  'unit_measurement': _u.text.toUpperCase(),
                  'brand': _b.text.toUpperCase(),
                }, product['recid']).then((saved){
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pushReplacementNamed(ProductPage.tag);
                });
              },
            ),

            FlatButton(
              color: LayoutWidget.danger(),
              child: Text('Cancelar', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        );
      }
    );
  }

  static List<Widget> syncAction(context) {
    TextEditingController _c1 = TextEditingController();
    List<Widget> items = List<Widget>();

    final Widget value = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'ATUALIZAR TABELA PRODUTO',
            style: TextStyle(
              fontSize: 15,
              color: LayoutWidget.primary() ,
              fontWeight: FontWeight.bold
            )
          ) ,
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Download', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                LoginModelJson loginJson = LoginModelJson();
                
                loginJson.users = HomePage.user;
                loginJson.password = HomePage.password;
                loginJson.email = HomePage.email;
                staticLoginJson = loginJson;
                postOrGet = 'get';
                
                Navigator.pushReplacementNamed(context, SynchronizeProductCircularProgress.tag);
              },
            ),

            FlatButton(
              color: LayoutWidget.danger(),
              child: Text('UpLoad', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){

                LoginModelJson loginJson = LoginModelJson();
                
                loginJson.users = HomePage.user;
                loginJson.password = HomePage.password;
                loginJson.email = HomePage.email;
                staticLoginJson = loginJson;
                postOrGet = 'post';
                
                Navigator.pushReplacementNamed(context, SynchronizeProductCircularProgress.tag);
              },
            ),

            FlatButton(
              color: LayoutWidget.dark(),
              child: Text('Sair', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    ) as Widget;
    
    items.add(value);

    return items;
  }
}
