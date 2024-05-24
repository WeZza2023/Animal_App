class GetAnimalsModel {
  bool? success;
  Data? data;
  late int statusCode;

  GetAnimalsModel.fromJson(List<dynamic> json) {
    success = json[0]['success'];
    statusCode = json[1];
    data = json[0]['data'] != null ? Data.fromJson(json[0]['data']) : null;
  }
}

class Data {
  late String currentPage;
  List<Animal>? animals;
  late String firstPageUrl;
  late String from;
  late String lastPage;
  late String lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  late String path;
  late String perPage;
  String? prevPageUrl;
  late String to;
  late String total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'].toString();
    animals = json['data'] != null ? (json['data'] as List).map((i) => Animal.fromJson(i)).toList() : null;
    firstPageUrl = json['first_page_url'];
    from = json['from'].toString();
    lastPage = json['last_page'].toString();
    lastPageUrl = json['last_page_url'];
    links = json['links'] != null ? (json['links'] as List).map((i) => Link.fromJson(i)).toList() : null;
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'].toString();
    prevPageUrl = json['prev_page_url'];
    to = json['to'].toString();
    total = json['total'].toString();
  }
}

class Animal {
  late String id;
  late String title;
  late String location;
  late String type;
  late String age;
  late String sex;
  late String adaptReason;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String userId;
  List<Image>? images;

  Animal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    location = json['location'];
    type = json['type'];
    age = json['age'].toString();
    sex = json['sex'];
    adaptReason = json['adapt_reason'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    userId = json['user_id'].toString();
    images = json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null;
  }
}

class Image {
  late int id;
  late String path;
  late int animalId;

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    animalId = json['animal_id'];
  }
}

class Link {
  String? url;
  late String label;
  late bool active;

  Link.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
