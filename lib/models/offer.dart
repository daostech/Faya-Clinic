import 'dart:convert';

import 'dart:math';

import 'package:faya_clinic/common/listable.dart';
import 'package:faya_clinic/constants/constants.dart';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer implements ListAble {
  Offer({
    this.id,
    this.title,
    this.description,
    this.img1,
    this.img2,
    this.img3,
    this.creationDate,
    this.isActive,
  });

  String id;
  String title;
  String description;
  String img1;
  String img2;
  String img3;
  dynamic creationDate;
  bool isActive;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String _imageUrl(String img) => "$IMG_PREFIX$img";

  List<String> get images {
    List<String> tmps = [img1, img2, img3];
    List<String> imgs = [];
    for (int i = 0; i < 3; i++) {
      if (tmps[i] != null) imgs.add(_imageUrl(tmps[i]));
    }
    return imgs;
  }

  String get randomImage {
    final existImages = images;
    if (existImages == null || existImages.isEmpty) return "";
    String image;
    do {
      int rand = Random().nextInt(images.length);
      image = existImages[rand];
      print("trying to get random image");
    } while (image == null);
    return image;
  }

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        title: json["title"],
        description: json["text"],
        img1: json["img1"],
        img2: json["img2"],
        img3: json["img3"],
        creationDate: json["creationDate"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "capition": description,
        "img1": img1,
        "img2": img2,
        "img3": img3,
        "creationDate": creationDate,
        "isActive": isActive,
      };

  @override
  bool containsKeyword(String keyword) {
    return title.toLowerCase().contains(keyword.toLowerCase());
  }

  @override
  String get titleValue => title;

  @override
  String get imageUrl => images != null && images.isNotEmpty ? images[0] : "";
}
