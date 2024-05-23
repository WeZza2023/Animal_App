class LoginModel {
  bool? success;
  late String message;
  UserData? data;
  late String token;

  LoginModel.fromJson(List<dynamic> json) {
    success = json[0]['success'];
    message = json[0]['message'];
    token = json[0]['token'];
    data = json[0]['data'] != null ? UserData.fromJson(json[0]['data']) : null;
  }
}

class UserData {
  int? id;
  late String name;
  String? email;
  late String phone;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}
