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

loadCategoryList(Future<List<Map<dynamic,dynamic>>> futureList) async{
  ShoppingListCategoryTempModel shoppingListCategoryTempModel = ShoppingListCategoryTempModel();
  
  futureList.asStream().forEach((mapList){
    for(int i = 0; i < mapList.length; i++){
      Map map = mapList[i];
      
      shoppingListCategoryTempModel.insert({
        'refid_category': map['recid'],
        'category': map['category'],
        'checked': 0
      });
    }
  });

  /*snapshotList.asStream((snap) {
      shoppingListCategoryTempModel.insert({
        'refid_category': snap['recid'],
        'category': snap['category'],
        'checked': 0
      });
  });*/
}
