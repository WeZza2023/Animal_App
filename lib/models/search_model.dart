class SearchModel {
  List<Data>? data;

  SearchModel({this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
