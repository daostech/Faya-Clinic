import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    this.label,
    this.country,
    this.city,
    this.apartment,
    this.street,
    this.block,
    this.zipCode,
    this.formatted,
  });

  String id;
  String label;
  String country;
  String city;
  String apartment;
  String street;
  String block;
  int zipCode;
  String formatted;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        label: json["label"],
        country: json["country"],
        city: json["city"],
        apartment: json["apartment"],
        street: json["street"],
        block: json["block"],
        zipCode: json["zipCode"],
        formatted: json["formatted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "country": country,
        "city": city,
        "apartment": apartment,
        "street": street,
        "block": block,
        "zipCode": zipCode,
        "formatted": formatted,
      };
}
