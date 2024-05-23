import 'package:intl/intl.dart';

class GetRequestsModel {
  List<Data>? data;

  GetRequestsModel({this.data});

  GetRequestsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? animalId;
  dynamic title;
  dynamic fee;
  String? createdAt;
  String? updatedAt;
  String? status;
  Animal? animal;

  Data({
    this.id,
    this.userId,
    this.animalId,
    this.title,
    this.fee,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.animal,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    animalId = json['animal_id'];
    title = json['title'];
    fee = json['fee'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    animal = json['animal'] != null ? Animal.fromJson(json['animal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['animal_id'] = animalId;
    data['title'] = title;
    data['fee'] = fee;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    if (animal != null) {
      data['animal'] = animal!.toJson();
    }
    return data;
  }

  String getDuration() {
    if (createdAt == null) return "Unknown";
    final createdAtDate = DateTime.parse(createdAt!);
    final duration = DateTime.now().difference(createdAtDate);
    return _formatDuration(duration);
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return "${duration.inDays} day(s) ago";
    } else if (duration.inHours > 0) {
      return "${duration.inHours} hour(s) ago";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes} minute(s) ago";
    } else {
      return "Just now";
    }
  }
}

class Animal {
  int? id;
  String? title;
  String? location;
  String? type;
  String? age;
  String? sex;
  String? adaptReason;
  String? createdAt;
  String? updatedAt;
  int? userId;

  Animal({
    this.id,
    this.title,
    this.location,
    this.type,
    this.age,
    this.sex,
    this.adaptReason,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  Animal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    type = json['type'];
    age = json['age'];
    sex = json['sex'];
    adaptReason = json['adapt_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['location'] = location;
    data['type'] = type;
    data['age'] = age;
    data['sex'] = sex;
    data['adapt_reason'] = adaptReason;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    return data;
  }

  String getDuration() {
    if (createdAt == null) return "Unknown";
    final createdAtDate = DateTime.parse(createdAt!);
    final duration = DateTime.now().difference(createdAtDate);
    return _formatDuration(duration);
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return "${duration.inDays} day(s) ago";
    } else if (duration.inHours > 0) {
      return "${duration.inHours} hour(s) ago";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes} minute(s) ago";
    } else {
      return "Just now";
    }
  }
}
