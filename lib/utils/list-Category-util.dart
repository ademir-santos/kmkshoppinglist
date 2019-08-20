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

loadCategoryList(Future<List<Map<dynamic,dynamic>>> snapshotList) async{
  ShoppingListCategoryTempModel shoppingListCategoryTempModel = ShoppingListCategoryTempModel();
  
  snapshotList.asStream((snap){
      shoppingListCategoryTempModel.insert({
        'refid_category': snap['recid'],
        'category': snap['category'],
        'checked': 0
      });
  });
}
