import 'dart:convert';

import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/models/storage_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'address.g.dart';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

@HiveType(typeId: HiveKeys.TYPE_ADDREESS)
class Address extends StorageModel {
  Address({
    this.id,
    this.label,
    this.country,
    this.city,
    this.apartment,
    this.street,
    this.block,
    this.zipCode,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String label;
  @HiveField(2)
  String country;
  @HiveField(3)
  String city;
  @HiveField(4)
  String apartment;
  @HiveField(5)
  String street;
  @HiveField(6)
  String block;
  @HiveField(7)
  int zipCode;

  String get formatted => "$country $city $street $apartment $block";

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        label: json["label"] == null ? null : json["label"],
        country: json["country"] == null ? null : json["country"],
        city: json["city"] == null ? null : json["city"],
        apartment: json["apartment"] == null ? null : json["apartment"],
        street: json["street"] == null ? null : json["street"],
        block: json["block"] == null ? null : json["block"],
        zipCode: json["zipCode"] == null ? null : json["zipCode"],
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
      };

  Map<String, dynamic> toJsonForOrder() => {
        "Id": id,
        "label": label,
        "Country": country,
        "City": city,
        "Apartment": apartment,
        "Street": street,
        "Block": block,
        "ZipCode": zipCode,
      };

  @override
  String get primaryKey => this.id ?? Uuid().v4();
}
