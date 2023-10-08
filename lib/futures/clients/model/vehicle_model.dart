class VehicleModel {
  int? tripsCount;
  String? model;
  List<String>? images;

  VehicleModel({this.tripsCount, this.model, this.images});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    tripsCount = json['tripsCount'];
    model = json['model'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['tripsCount'] = tripsCount;
    data['model'] = model;
    data['images'] = images;
    return data;
  }
}