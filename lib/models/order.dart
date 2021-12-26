import 'dart:convert';

import 'package:faya_clinic/models/order_item.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.userId,
    this.orderCode,
    this.date,
    this.status,
    this.client,
    this.total,
    this.orderItems,
  });

  String id;
  String userId;
  String orderCode;
  int date;
  int status;
  int client;
  int total;
  List<OrderItem> orderItems;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        orderCode: json["orderCode"] == null ? null : json["orderCode"],
        date: json["date"] == null ? null : json["date"],
        status: json["status"] == null ? null : json["status"],
        client: json["client"] == null ? null : json["client"],
        total: json["total"] == null ? null : json["total"],
        orderItems: json["orderItems"] == null ? null : List<dynamic>.from(json["orderItems"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "orderCode": orderCode,
        "date": date,
        "status": status,
        "client": client,
        "total": total,
        "orderItems": orderItems == null ? null : List<dynamic>.from(orderItems.map((x) => x)),
      };
}
