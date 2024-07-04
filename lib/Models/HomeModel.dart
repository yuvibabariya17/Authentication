import 'dart:convert';

List<HomeModel> welcomeFromJson(String str) =>
    List<HomeModel>.from(json.decode(str).map((x) => HomeModel.fromJson(x)));

String welcomeToJson(List<HomeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeModel {
  int userId;
  int id;
  String title;
  String body;

  HomeModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
