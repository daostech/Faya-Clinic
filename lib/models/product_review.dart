import 'dart:convert';

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
  });

  String id;
  String userId;
  String productId;
  String text;
  int rate;
  bool isVisible;
  DateTime creationDate;

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
        id: json["id"],
        userId: json["userId"],
        productId: json["productId"],
        text: json["text"],
        rate: json["rate"],
        isVisible: json["isVisible"],
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "productId": productId,
        "text": text,
        "rate": rate,
        "isVisible": isVisible,
        "creationDate": creationDate.toIso8601String(),
      };
}
