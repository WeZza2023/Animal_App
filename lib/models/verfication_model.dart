class VerificationErrorModel {
  bool? success;
  Null? data;
  Errors? errors;

  VerificationErrorModel({this.success, this.data, this.errors});

  VerificationErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email;
  List<String>? phone;

  Errors({this.email, this.phone});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'] != null ? List<String>.from(json['email']) : null;
    phone = json['phone'] != null ? List<String>.from(json['phone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (email != null) {
      data['email'] = email;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    return data;
  }
}

class VerificationSuccessModel {
  bool? success;
  Null? data;
  String? message;
  int? statusCode;

  VerificationSuccessModel(
      {this.success, this.data, this.message, this.statusCode});

  VerificationSuccessModel.fromJson(List<dynamic> json) {
    success = json[0]['success'];
    data = json[0]['data'];
    message = json[0]['message'];
    statusCode = json[1];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}
