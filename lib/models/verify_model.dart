class VerifyModel {
  String? code;
  late String link;
  late String deep_link;

  VerifyModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    link = json['link'];
    deep_link = json['deep_link'];
  }
}

