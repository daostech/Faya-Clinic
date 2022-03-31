import 'dart:convert';

import 'package:faya_clinic/constants/config.dart';

Team teamFromJson(String str) => Team.fromJson(json.decode(str));

String teamToJson(Team data) => json.encode(data.toJson());

class Team {
  Team({
    this.id,
    this.image,
    this.name,
    this.description,
  });

  String id;
  String image;
  String name;
  String description;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String get imageUrl => "${AppConfig.BASE_URL}$image";

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        description: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "text": description,
      };
}
