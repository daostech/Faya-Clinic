import 'dart:convert';

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
