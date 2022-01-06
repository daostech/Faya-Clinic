import 'dart:convert';

import 'dart:math';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
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

  String id;
  String name;
  String description;
  String img1;
  String img2;
  String img3;
  String img4;
  String categoryId;
  String subCategoryId;
  double price;
  dynamic creationDate;

  List<String> get images {
    List<String> tmps = [img1, img2, img3];
    List<String> imgs = [];
    for (int i = 0; i < 3; i++) {
      if (tmps[i] != null) imgs.add(tmps[i]);
    }
    return imgs;
  }

  String get randomImage {
    final existImages = images;
    if (existImages == null || (existImages?.isEmpty ?? null)) return "";
    String image;
    do {
      int rand = Random().nextInt(images.length);
      image = existImages[rand];
      print("trying to get random image");
    } while (image == null);
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
        creationDate: json["creationDate"],
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
        "creationDate": creationDate,
      };
}
