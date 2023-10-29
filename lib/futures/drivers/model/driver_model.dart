class DriverModel {
  Rating? rating;
  String? sId;
  String? name;
  String? gender;
  int? age;
  String? email;
  bool? verified;
  String? password;
  String? image;
  String? phone;
  int? status;
  bool? available;
  int? iV;
  Vehicle? vehicle;

  DriverModel(
      {this.rating,
      this.sId,
      this.name,
      this.gender,
      this.age,
      this.email,
      this.verified,
      this.password,
      this.image,
      this.phone,
      this.status,
      this.available,
      this.iV,
      this.vehicle});

  DriverModel.fromJson(Map<String, dynamic> json) {
    rating =
        json['rating'] != null ?  Rating.fromJson(json['rating']) : null;
    sId = json['_id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    email = json['email'];
    verified = json['verified'];
    password = json['password'];
    image = json['image'];
    phone = json['phone'];
    status = json['status'];
    available = json['available'];
    iV = json['__v'];
    vehicle =
        json['vehicle'] != null ?  Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['email'] = email;
    data['verified'] = verified;
    data['password'] = password;
    data['image'] = image;
    data['phone'] = phone;
    data['status'] = status;
    data['available'] = available;
    data['__v'] = iV;
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    return data;
  }
}

class Rating {
  int? cool;
  int? good;
  int? fair;

  Rating({this.cool, this.good, this.fair});

  Rating.fromJson(Map<String, dynamic> json) {
    cool = json['cool'];
    good = json['good'];
    fair = json['fair'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cool'] = cool;
    data['good'] = good;
    data['fair'] = fair;
    return data;
  }
}

class Vehicle {
  String? category;
  List<String>? images;
  String? model;
  String? sId;

  Vehicle({this.category, this.images, this.model, this.sId});

  Vehicle.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    images = json['images'].cast<String>();
    model = json['model'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category'] = category;
    data['images'] = images;
    data['model'] = model;
    data['_id'] = sId;
    return data;
  }
}