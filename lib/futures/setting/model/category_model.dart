class CategoryModel {
  String? sId;
  String? name;
  String? image;
  int? commission;
  int? iV;

  CategoryModel({this.sId, this.name, this.image, this.iV, this.commission});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    commission = json['commission'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['commission'] = commission;
    data['__v'] = iV;
    return data;
  }
}
