class MyProfileModel {
  bool? success;
  UserData? data;

  MyProfileModel.fromJson(List<dynamic> json) {
    success = json[0]['data']['success'];
    data = json[0]['data']['data'] != null ? UserData.fromJson(json[0]['data']['data']) : null;
  }
}

class UserData {
  int? id;
  late String name;
  String? email;
  late String phone;
  String? emailVerifiedAt;
  late String password;
  String? rememberToken;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String deviceToken;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    deviceToken = json['device_token'];

  }
}