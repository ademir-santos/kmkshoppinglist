import 'package:kmkshoppinglist/models/ShoppingListCategoryModel.dart';
import 'package:kmkshoppinglist/models/ShoppingListCategoryTempModel.dart';

setcategoryList(int refIdShoppList, String listName, Map category){

  ShoppingListCategoryModel shoppingListCategoryModel = ShoppingListCategoryModel();

    return shoppingListCategoryModel.insert({
      'refid_shopplist': refIdShoppList,
      'list_name': listName,
      'refid_category': category['recid'],
      'category': category['category'],
      'checked': 1,
      'created': DateTime.now().toString()
    }).then((recId){
      //Navigator.of(ctx).pop();
      //Navigator.of(ctx).popAndPushNamed(ListMirrorCategory.tag);
    });    
}

loadCategoryList(Stream<List<Map>> futureList) async{
  ShoppingListCategoryTempModel shoppingListCategoryTempModel = ShoppingListCategoryTempModel();

  await for(var mapList in futureList){
    for(var map in mapList){
      shoppingListCategoryTempModel.insert({
          'refid_category': map['recid'],
          'category': map['category'],
          'checked': 0
      });
    }
  }
}
