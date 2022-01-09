class PostResponse {
  PostResponse({
    this.value,
    this.formatters,
    this.contentTypes,
    this.declaredType,
    this.statusCode,
  });

  String value;
  List<dynamic> formatters;
  List<dynamic> contentTypes;
  dynamic declaredType;
  int statusCode;

  bool get success => statusCode == 200;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        value: json["value"] == null ? null : json["value"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
      );
}
