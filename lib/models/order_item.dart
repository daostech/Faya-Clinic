import 'dart:convert';

import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/models/storage_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'order_item.g.dart';

OrderItem orderItemsFromJson(String str) => OrderItem.fromJson(json.decode(str));

String orderItemsToJson(OrderItem data) => json.encode(data.toJson());

@HiveType(typeId: HiveKeys.TYPE_ORDER_ITEM)
class OrderItem extends StorageModel {
  OrderItem({
    this.id,
    this.name,
    this.orderId,
    this.item,
    this.image,
    this.price,
    this.count,
    this.total,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String orderId;
  @HiveField(3)
  String item;
  @HiveField(4)
  String image;
  @HiveField(5)
  double price;
  @HiveField(6)
  int count;
  @HiveField(7)
  int total;

  double get totalPrice => price * count;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"] == null ? null : json["id"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        item: json["item"] == null ? null : json["item"],
        price: json["price"] == null ? null : json["price"],
        count: json["count"] == null ? null : json["count"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "orderId": orderId,
        "item": item,
        "image": image,
        "price": price,
        "count": count,
        "total": total,
      };

  @override
  String get primaryKey => this.id ?? Uuid().v4();
}
