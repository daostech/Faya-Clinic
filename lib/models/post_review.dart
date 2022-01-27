import 'dart:convert';

ProductReview productReviewFromJson(String str) => ProductReview.fromJson(json.decode(str));

String productReviewToJson(ProductReview data) => json.encode(data.toJson());

class ProductReview {
  ProductReview({
    this.id,
    this.userId,
    this.userName,
    this.productId,
    this.text,
    this.rate,
    this.creationDate,
  });

  String id;
  String userId;
  String userName;
  String productId;
  String text;
  int rate;
  DateTime creationDate;

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        productId: json["productId"],
        text: json["text"],
        rate: json["rate"],
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "productId": productId,
        "text": text,
        "rate": rate,
        "creationDate": creationDate.toIso8601String(),
      };
}
