import 'dart:convert';

ShoppingListCategoryModel clientFromJson(String str) {
    final jsonData = json.decode(str);
    return ShoppingListCategoryModel.fromJson(jsonData);
}

String clientToJson(ShoppingListCategoryModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class ShoppingListCategoryModel {
  int recid;
  int refid_shopplist;
  String list_name;
  int refid_category;
  String categorys;
  int quantity_total;
  double value_total;
  int checked;
  String created;

  ShoppingListCategoryModel({
      this.recid,
      this.refid_shopplist,
      this.list_name,
      this.refid_category,
      this.categorys,
      this.quantity_total,
      this.value_total,
      this.checked,
      this.created
  });
  /*
  int get recid => recid;
  int get refid_shopplist => refid_shopplist;
  String get list_name => list_name;
  int get refid_category => refid_category;
  String get categorys => categorys;
  int get quantity_total => quantity_total;
  double get value_total => value_total;
  int get checked => checked;
  String get created => created;*/

  factory ShoppingListCategoryModel.fromJson(Map<String, dynamic> data) => new ShoppingListCategoryModel(
      recid: data["recid"],
      refid_shopplist: data["refid_shopplist"],
      list_name: data["list_name"],
      refid_category: data["refid_category"],
      categorys: data["categorys"],
      quantity_total: data["quantity_total"],
      value_total: data["value_total"],
      checked: data["checked"],
      created: data["created"],
  );

  Map<String, dynamic> toJson() => {
      "recid": recid,
      "refid_shopplist": refid_shopplist,
      "list_name": list_name,
      "refid_category": refid_category,
      "categorys": categorys,
      "quantity_total": quantity_total,
      "value_total": value_total,
      "checked": checked,
      "created": created,
  };
}