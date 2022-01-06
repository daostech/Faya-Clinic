import 'dart:convert';

HomeSlider homeSliderFromJson(String str) => HomeSlider.fromJson(json.decode(str));

String homeSliderToJson(HomeSlider data) => json.encode(data.toJson());

class HomeSlider {
  HomeSlider({
    this.id,
    this.image,
    this.description,
  });

  String id;
  String image;
  String description;

  factory HomeSlider.fromJson(Map<String, dynamic> json) => HomeSlider(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        description: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "text": description,
      };
}
