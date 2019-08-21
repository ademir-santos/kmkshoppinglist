import 'package:kmkshoppinglist/models/ShoppingListCategoryModel.dart';
import 'package:kmkshoppinglist/models/ShoppingListCategoryTempModel.dart';

setcategoryList(int refIdShoppList, String listName, Map category){

  ShoppingListCategoryModel shoppingListCategoryModel = ShoppingListCategoryModel();

    return shoppingListCategoryModel.insert({
      'refid_shopplist': refIdShoppList,
      'list_name': listName,
      'refid_category': category['recid'],
      'category': category['categorys'],
      'checked': 1,
      'created': DateTime.now().toString()
    }).then((recId){
      //Navigator.of(ctx).pop();
      //Navigator.of(ctx).popAndPushNamed(ListMirrorCategory.tag);
    });    
}

loadCategoryList(Stream<List<Map>> futureList) async{
  ShoppingListCategoryTempModel shoppingListCategoryTempModel = ShoppingListCategoryTempModel();
  bool exists = false;

  await for(var mapList in futureList){

    for(var map in mapList){
      String category = map['categorys'].toString();

      if(category.isNotEmpty){
        exists = await shoppingListCategoryTempModel.getItemExist(category);

        if(exists){
          shoppingListCategoryTempModel.insert({
            'refid_category': map['recid'],
            'categorys': map['categorys'],
            'checked': 0
          });
        }
      }
    }
  }
}
