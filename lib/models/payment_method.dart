import 'dart:convert';

PaymentMethod paymentMethodFromJson(String str) => PaymentMethod.fromJson(json.decode(str));

String paymentMethodToJson(PaymentMethod data) => json.encode(data.toJson());

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.method,
    this.image,
  });

  String? id;
  String? method;
  String? image;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        method: json["method"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
        "image": image,
      };
}
