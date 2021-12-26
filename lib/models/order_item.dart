import 'dart:convert';

OrderItem orderItemsFromJson(String str) => OrderItem.fromJson(json.decode(str));

String orderItemsToJson(OrderItem data) => json.encode(data.toJson());

class OrderItem {
  OrderItem({
    this.id,
    this.orderId,
    this.item,
    this.price,
    this.count,
    this.total,
    this.orders,
  });

  String id;
  String orderId;
  String item;
  int price;
  int count;
  int total;
  List<dynamic> orders; // ! what orders

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"] == null ? null : json["id"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        item: json["item"] == null ? null : json["item"],
        price: json["price"] == null ? null : json["price"],
        count: json["count"] == null ? null : json["count"],
        total: json["total"] == null ? null : json["total"],
        orders: json["orders"] == null ? null : List<dynamic>.from(json["orders"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "item": item,
        "price": price,
        "count": count,
        "total": total,
        "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x)),
      };
}
