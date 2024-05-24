import 'package:animal_app/generated/l10n.dart';

class GetNotificationsModel {
  List<Data>? data;

  GetNotificationsModel({this.data});

  GetNotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  Null? title;
  String? fee;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? ownerId;
  Animal? animal;

  Data(
      {this.id,
        this.userId,
        this.animalId,
        this.title,
        this.fee,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.ownerId,
        this.animal});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    animalId = json['animal_id'];
    title = json['title'];
    fee = json['fee'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    ownerId = json['owner_id'];
    animal =
    json['animal'] != null ? new Animal.fromJson(json['animal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['animal_id'] = this.animalId;
    data['title'] = this.title;
    data['fee'] = this.fee;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['owner_id'] = this.ownerId;
    if (this.animal != null) {
      data['animal'] = this.animal!.toJson();
    }
    return data;
  }

  String getDuration(context) {
    if (createdAt == null) return "Unknown";
    final createdAtDate = DateTime.parse(createdAt!);
    final duration = DateTime.now().difference(createdAtDate);
    return _formatDuration(duration,context);
  }

  String _formatDuration(Duration duration,context) {
    if (duration.inDays > 0) {
      return "${S.of(context).ago} ${duration.inDays} ${S.of(context).days}";
    } else if (duration.inHours > 0) {
      return "${S.of(context).ago} ${duration.inHours} ${S.of(context).hours}";
    } else if (duration.inMinutes > 0) {
      return "${S.of(context).ago} ${duration.inMinutes} ${S.of(context).minutes}";
    } else {
      return S.of(context).justNow;
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
  List<Images>? images;

  Animal(
      {this.id,
        this.title,
        this.location,
        this.type,
        this.age,
        this.sex,
        this.adaptReason,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.images});

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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['location'] = this.location;
    data['type'] = this.type;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['adapt_reason'] = this.adaptReason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? path;
  int? animalId;

  Images({this.id, this.path, this.animalId});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    animalId = json['animal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['animal_id'] = this.animalId;
    return data;
  }
}
