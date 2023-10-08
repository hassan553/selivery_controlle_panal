class HomeModel {
  final int driversNo;
  final int usersNo;
  final int salesVehiclesNo;
  final int rentVehiclesNo;

  HomeModel({
     this.driversNo=0,
     this.usersNo=0,
     this.salesVehiclesNo=0,
     this.rentVehiclesNo=0,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      driversNo: json['driversNo'] as int,
      usersNo: json['usersNo'] as int,
      salesVehiclesNo: json['salesVehiclesNo'] as int,
      rentVehiclesNo: json['rentVehiclesNo'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driversNo': driversNo,
      'usersNo': usersNo,
      'salesVehiclesNo': salesVehiclesNo,
      'rentVehiclesNo': rentVehiclesNo,
    };
  }
}
