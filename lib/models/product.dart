import 'dart:convert';

import 'dart:math';

import 'package:faya_clinic/common/listable.dart';
import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/models/storage_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

@HiveType(typeId: HiveKeys.TYPE_PRODUCT)
class Product extends StorageModel implements ListAble {
  Product({
    this.id,
    this.name,
    this.description,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.categoryId,
    this.subCategoryId,
    this.price,
    this.creationDate,
  });
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? img1;
  @HiveField(4)
  String? img2;
  @HiveField(5)
  String? img3;
  @HiveField(6)
  String? img4;
  @HiveField(7)
  String? categoryId;
  @HiveField(8)
  String? subCategoryId;
  @HiveField(9)
  double? price;
  @HiveField(10)
  DateTime? creationDate;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String _imageUrl(String? img) => "${AppConfig.RAW_BASE_URL}/$img";

  List<String> get images {
    List<String?> tmps = [img1, img2, img3];
    List<String> imgs = [];
    for (int i = 0; i < 3; i++) {
      if (tmps[i] != null) imgs.add(_imageUrl(tmps[i]));
    }
    return imgs;
  }

  String get randomImage {
    final existImages = images;
    if (existImages.isEmpty) return "";
    String image;
    do {
      int rand = Random().nextInt(images.length);
      image = existImages[rand];
      print("trying to get random image");
    } while (image.isEmpty);
    return image;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["productName"],
        description: json["capition"],
        img1: json["img1"],
        img2: json["img2"],
        img3: json["img3"],
        img4: json["img4"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        price: json["price"],
        creationDate: json["creationDate"] == null ? null : DateTime.tryParse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": name,
        "capition": description,
        "img1": img1,
        "img2": img2,
        "img3": img3,
        "img4": img4,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "price": price,
        "creationDate": creationDate?.toIso8601String(),
      };

  @override
  String get primaryKey => this.id ?? Uuid().v4();

  @override
  bool containsKeyword(String keyword) {
    return name!.toLowerCase().contains(keyword.toLowerCase());
  }

  @override
  String? get titleValue => name;

  @override
  String get imageUrl => images.isNotEmpty ? images[0] : "";
}
