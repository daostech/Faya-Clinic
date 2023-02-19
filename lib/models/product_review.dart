import 'dart:convert';

import 'package:faya_clinic/models/user.dart';

ProductReview productReviewFromJson(String str) => ProductReview.fromJson(json.decode(str));

String productReviewToJson(ProductReview data) => json.encode(data.toJson());

class ProductReview {
  ProductReview({
    this.id,
    this.userId,
    this.productId,
    this.text,
    this.rate,
    this.isVisible,
    this.creationDate,
    this.user,
  });

  String? id;
  String? userId;
  String? productId;
  String? text;
  int? rate;
  bool? isVisible;
  DateTime? creationDate;
  MyUser? user;

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        productId: json["productId"] == null ? null : json["productId"],
        text: json["text"] == null ? null : json["text"],
        rate: json["rate"] == null ? null : json["rate"],
        isVisible: json["isVisible"] == null ? null : json["isVisible"],
        user: json["mobileUsers"] == null ? null : MyUser.fromJson(json["mobileUsers"]),
        creationDate: json["creationDate"] == null ? null : DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "productId": productId,
        "text": text,
        "rate": rate,
        "isVisible": isVisible,
        "mobileUsers": user!.toJson(),
        "creationDate": creationDate!.toIso8601String(),
      };
}
