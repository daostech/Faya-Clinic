import 'dart:convert';

ShippingMethod shippingMethodFromJson(String str) => ShippingMethod.fromJson(json.decode(str));

String shippingMethodToJson(ShippingMethod data) => json.encode(data.toJson());

class ShippingMethod {
  ShippingMethod({
    this.id,
    this.method,
    this.price,
    this.priceString,
    this.unite,
  });

  String id;
  String method;
  double price;
  String priceString;
  String unite;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
        id: json["id"],
        method: json["method"],
        price: json["price"],
        priceString: json["priceString"],
        unite: json["unite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
        "price": price,
        "priceString": priceString,
        "unite": unite,
      };
}
