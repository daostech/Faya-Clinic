import 'dart:convert';

Coupon couponFromJson(String str) => Coupon.fromJson(json.decode(str));

String couponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
  Coupon({
    this.id,
    this.title,
    this.discountValue,
    this.creationDate,
    this.endDate,
  });

  String id;
  String title;
  int discountValue;
  DateTime creationDate;
  DateTime endDate;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        title: json["title"],
        discountValue: json["discountValue"],
        creationDate: json["creationDate"] == null ? null : DateTime.parse(json["creationDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "discountValue": discountValue,
        "creationDate": creationDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
