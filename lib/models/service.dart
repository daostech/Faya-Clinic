import 'dart:convert';

ClinicService serviceFromJson(String str) => ClinicService.fromJson(json.decode(str));

String serviceToJson(ClinicService data) => json.encode(data.toJson());

class ClinicService {
  ClinicService({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory ClinicService.fromJson(Map<String, dynamic> json) => ClinicService(
        id: json["subCategories"] == null ? null : json["id"],
        name: json["subCategories"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
