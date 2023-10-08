// user_model.dart

class DriverModel {
  final String? name;
  final String? phone;
  final String? image;
  final String? id;

  DriverModel({
    this.name,
    this.phone,
    this.image,
    this.id,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'image': image,
      '_id': id,
    };
  }
}
