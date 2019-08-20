class ShippingListCategoryUtil {
  final int recid;
  final int refid_shopplist;
  final String list_name;
  final int refid_category;
  final String category;
  final int quantity_total;
  final double value_total; 
  final int checked;
  final String created;

  ShippingListCategoryUtil({
    this.recid, 
    this.refid_shopplist, 
    this.list_name, 
    this.refid_category, 
    this.category, 
    this.quantity_total, 
    this.value_total, 
    this.checked, 
    this.created
  });

  factory ShippingListCategoryUtil.fromJson(Map<String, dynamic> json){
    return new ShippingListCategoryUtil(
      recid: json['recid'],
      refid_shopplist: json['refid_shopplist'],
      list_name: json['list_name'],
      refid_category: json['list_name'],
      category: json['listname'],
      quantity_total: json['list_name'],
      value_total:json['list_name'],
      checked: json['list_name'],
      created: json['list_name']
    );
  }
}