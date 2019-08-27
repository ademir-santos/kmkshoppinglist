import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kmkshoppinglist/dao/ShopplistCategoryProductDao.dart';
import 'package:kmkshoppinglist/page/home/list-home/list-mirror-product.dart';
import 'package:kmkshoppinglist/page/layout-base/layout-widget.dart';

class ListProductWidget {

  static void showEditDialog(BuildContext context, Map shoppListCategory){
    TextEditingController _qt = TextEditingController(text: '1');
    MoneyMaskedTextController _vl = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: ',',
      leftSymbol: 'R\$ '
    );

    _qt.text = shoppListCategory['quantity_total'].toString();
    _vl.text = shoppListCategory['value_unitary'].toString();

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {

        final inputLitQty = TextFormField(
          controller: _qt,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Quantidade',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        final inputLitValue = TextFormField(
          controller: _vl,
          autofocus: false,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: 'Valor R\$',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10)
          ),
        );

        return AlertDialog(
          title: Text('Editar lista'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                inputLitQty,
                SizedBox(height: 30),
                inputLitValue
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: LayoutWidget.primary(),
              child: Text('Salva', style: TextStyle(color: LayoutWidget.light())),
              onPressed: (){
                ShopplistCategoryProductDao shopplistCategoryProductDao = ShopplistCategoryProductDao();
                int qtyTotal = (int.tryParse(_qt.text) ?? 1);
                int recId = shoppListCategory['recid'];
                double valueAsDouble;
                double vlTotal;

                try{
                  valueAsDouble = num.parse(_vl.numberValue.toStringAsPrecision(3));
                  vlTotal = qtyTotal * num.parse(valueAsDouble.toStringAsPrecision(3));
                } catch (exception, stack) {
                  valueAsDouble = _vl.numberValue;
                   vlTotal = qtyTotal * valueAsDouble;
                }
               
                shopplistCategoryProductDao.update({
                  'value_unitary': valueAsDouble,
                  'quantity_total': qtyTotal,
                  'value_total': vlTotal
                }, recId).then((saved){
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pushReplacementNamed(ListMirrorProductPage.tag);
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
}