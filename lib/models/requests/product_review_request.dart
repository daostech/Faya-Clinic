import 'dart:convert';

String productReviewToJson(ProductReviewRequest data) => json.encode(data.toJson());

class ProductReviewRequest {
  ProductReviewRequest({
    this.userId,
    this.productId,
    this.text,
    this.rate,
  });

  String userId;
  String productId;
  String text;
  int rate;

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "productId": productId,
        "text": text,
        "rate": rate,
      };
}
