import 'package:kmkshoppinglist/dao/UserShoppingListDao.dart';
import 'package:kmkshoppinglist/page/home/home.dart';

updateQtyVlList(dynamic vl, dynamic qty) async{
  UserShoppingListDao userShoppingListDao = UserShoppingListDao();

  userShoppingListDao.updateSelect(HomePage.refId, vl);
}
