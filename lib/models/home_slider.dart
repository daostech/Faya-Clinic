import 'dart:convert';

import 'package:faya_clinic/constants/config.dart';

HomeSlider homeSliderFromJson(String str) => HomeSlider.fromJson(json.decode(str));

String homeSliderToJson(HomeSlider data) => json.encode(data.toJson());

class HomeSlider {
  HomeSlider({
    this.id,
    this.image,
    this.description,
  });

  String? id;
  String? image;
  String? description;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String get imageUrl => "${AppConfig.RAW_BASE_URL}/$image";

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
