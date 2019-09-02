import 'dart:convert';

import 'package:kmkshoppinglist/dao/CategoryDao.dart';

class CategoryJsonModel {
  String categorys;
  var id;
  int recid;
  var createAt;
  var updateAt;

  CategoryJsonModel({ 
    this.categorys, 
    this.id, 
    this.recid, 
    this.createAt, 
    this.updateAt
  });

  factory CategoryJsonModel.fromJson(Map<String, dynamic> parsedJson) {
    return CategoryJsonModel(
      categorys: parsedJson['categorys'],
      id: parsedJson['id'],
      recid: parsedJson['recid'],
      createAt: parsedJson['createAt'],
      updateAt: parsedJson['updateAt']
    );
  }

  Map<String, dynamic> toJson() => {

    "categorys": categorys,

    "recid": recid,

    "createAt": createAt,

    "updateAt": updateAt 
  };
}


CategoryJsonModel postCategoryFromJson(String str) {

  final jsonData = json.decode(str);

  return CategoryJsonModel.fromJson(jsonData);

}

String postCategoryToJson(CategoryJsonModel data) {

  final dyn = data.toJson();

  return json.encode(dyn);

}

List<CategoryJsonModel> allPostsFromJson(String str) {

  final jsonData = json.decode(str);

  return new List<CategoryJsonModel>.from(jsonData.map((x) => CategoryJsonModel.fromJson(x)));

}

Future<List<Map>> allPostsListBloc(CategoryJsonModel model) async {

  CategoryDao dao = new CategoryDao();

  final listModel =  new List<Map>();

  listModel.addAll(await dao.list(0));

  return listModel;
}

String allPostsToJson(List<CategoryJsonModel> data) {

  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));

  return json.encode(dyn);

}