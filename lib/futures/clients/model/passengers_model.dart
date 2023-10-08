class PassengerModel {
  String? sId;
  int? tripsCount;
  String? passenger;
  String? email;
  String? phone;
  String? image;

  PassengerModel(
      {this.sId,
      this.tripsCount,
      this.passenger,
      this.email,
      this.phone,
      this.image});

  PassengerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tripsCount = json['tripsCount'];
    passenger = json['passenger'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['tripsCount'] = this.tripsCount;
    data['passenger'] = this.passenger;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    return data;
  }
}