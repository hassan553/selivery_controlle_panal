class CategoryModel {
  String? sId;
  String? name;
  String? image;
  int? iV;

  CategoryModel({this.sId, this.name, this.image, this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['__v'] = iV;
    return data;
  }
}