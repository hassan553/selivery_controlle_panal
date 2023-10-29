class DriverLicenseModel {
  String? sId;
  String? vehicleName;
  List<String>? vehicleImages;
  String? nationalId;
  String? vehicleLicense;
  String? driverLicense;
  List<DriverData>? driverData;

  DriverLicenseModel(
      {this.sId,
      this.vehicleName,
      this.vehicleImages,
      this.nationalId,
      this.vehicleLicense,
      this.driverLicense,
      this.driverData});

  DriverLicenseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicleName = json['vehicle_name'];
    vehicleImages = json['vehicle_images'].cast<String>();
    nationalId = json['National_id'];
    vehicleLicense = json['vehicle_license'];
    driverLicense = json['driver_license'];
    if (json['driverData'] != null) {
      driverData = <DriverData>[];
      json['driverData'].forEach((v) {
        driverData!.add(DriverData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['vehicle_name'] = vehicleName;
    data['vehicle_images'] = vehicleImages;
    data['National_id'] = nationalId;
    data['vehicle_license'] = vehicleLicense;
    data['driver_license'] = driverLicense;
    if (driverData != null) {
      data['driverData'] =driverData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverData {
  String? name;
  int? age;
  String? email;
  String? image;

  DriverData({this.name, this.age, this.email, this.image});

  DriverData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['age'] = age;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}