import 'dart:convert';

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


CategoryJsonModel postFromJson(String str) {

  final jsonData = json.decode(str);

  return CategoryJsonModel.fromJson(jsonData);

}



String postToJson(CategoryJsonModel data) {

  final dyn = data.toJson();

  return json.encode(dyn);

}



List<CategoryJsonModel> allPostsFromJson(String str) {

  final jsonData = json.decode(str);

  return new List<CategoryJsonModel>.from(jsonData.map((x) => CategoryJsonModel.fromJson(x)));

}



String allPostsToJson(List<CategoryJsonModel> data) {

  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));

  return json.encode(dyn);

}