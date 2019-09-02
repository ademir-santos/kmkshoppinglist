import 'dart:convert';

import 'package:kmkshoppinglist/dao/ProductDao.dart';

class ProductModelJson {
  var products;
  var brand;
  var unit_measurement;
  var refid_category;
  var categorys;
  var id;
  var recid;
  var createAt;
  var updateAt;

  ProductModelJson({
                    this.products, 
                    this.brand, 
                    this.unit_measurement, 
                    this.refid_category, 
                    this.categorys, 
                    this.id, 
                    this.recid,
                    this.createAt,
                    this.updateAt});

  factory ProductModelJson.fromJson(Map<String, dynamic> parsedJson) {
    return ProductModelJson(
      products: parsedJson['products'],
      brand: parsedJson['brand'],
      unit_measurement: parsedJson['unit_measurement'],
      refid_category: parsedJson['refid_category'],
      categorys: parsedJson['categorys'],
      id: parsedJson['id'],
      recid: parsedJson['recid'],
      createAt: parsedJson['createAt'],
      updateAt: parsedJson['updateAt'],
    );
  }

  Map<String, dynamic> toJson() => {

    "products": products,

    "brand": brand,

    "unit_measurement": unit_measurement,

    "refid_category": refid_category,

    "categorys": categorys,

    "recid": recid,

    "createAt": createAt,

    "updateAt": updateAt 
  };
}

ProductModelJson postProductFromJson(String str) {

  final jsonData = json.decode(str);

  return ProductModelJson.fromJson(jsonData);

}

String postProductToJson(ProductModelJson data) {

  final dyn = data.toJson();

  return json.encode(dyn);

}

ProductModelJson postFromJson(String str) {

  final jsonData = json.decode(str);

  return ProductModelJson.fromJson(jsonData);

}

String postToJson(ProductModelJson data) {

  final dyn = data.toJson();

  return json.encode(dyn);

}

List<ProductModelJson> allPostsFromJson(String str) {

  final jsonData = json.decode(str);

  return new List<ProductModelJson>.from(jsonData.map((x) => ProductModelJson.fromJson(x)));

}

String allPostsToJson(List<ProductModelJson> data) {

  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));

  return json.encode(dyn);
}

Future<List<Map>> allPostsListBloc(ProductModelJson model, category) async {

  ProductDao dao = new ProductDao();

  final listModel =  new List<Map>();

  listModel.addAll(await dao.list(category));

  return listModel;
}