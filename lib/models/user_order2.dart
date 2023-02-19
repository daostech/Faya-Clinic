// To parse this JSON data, do
//
//     final userOrder2 = userOrder2FromJson(jsonString);

import 'dart:convert';

List<UserOrder2> userOrder2FromJson(String str) =>
    List<UserOrder2>.from(json.decode(str).map((x) => UserOrder2.fromJson(x)));

String userOrder2ToJson(List<UserOrder2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserOrder2 {
  UserOrder2({
    this.orderAddress,
    this.orderItems,
    this.id,
    this.userId,
    this.couponId,
    this.couponCode,
    this.orderCode,
    this.date,
    this.status,
    this.note,
    this.total,
    this.paymentMethod,
    this.paymentPrice,
    this.creationDate,
    this.productNames,
    this.productIds,
  });

  OrderAddress? orderAddress;
  List<OrderItem>? orderItems;
  String? id;
  String? userId;
  dynamic couponId;
  dynamic couponCode;
  String? orderCode;
  DateTime? date;
  String? status;
  String? note;
  int? total;
  String? paymentMethod;
  String? paymentPrice;
  DateTime? creationDate;
  dynamic productNames;
  dynamic productIds;

  factory UserOrder2.fromJson(Map<String, dynamic> json) => UserOrder2(
        orderAddress: OrderAddress.fromJson(json["orderAddress"]),
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
        id: json["id"],
        userId: json["userId"],
        couponId: json["couponId"],
        couponCode: json["couponCode"],
        orderCode: json["orderCode"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        note: json["note"],
        total: json["total"],
        paymentMethod: json["paymentMethod"],
        paymentPrice: json["paymentPrice"],
        creationDate: DateTime.parse(json["creationDate"]),
        productNames: json["productNames"],
        productIds: json["productIds"],
      );

  Map<String, dynamic> toJson() => {
        "orderAddress": orderAddress!.toJson(),
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "id": id,
        "userId": userId,
        "couponId": couponId,
        "couponCode": couponCode,
        "orderCode": orderCode,
        "date": date!.toIso8601String(),
        "status": status,
        "note": note,
        "total": total,
        "paymentMethod": paymentMethod,
        "paymentPrice": paymentPrice,
        "creationDate": creationDate!.toIso8601String(),
        "productNames": productNames,
        "productIds": productIds,
      };
}

class OrderAddress {
  OrderAddress();

  factory OrderAddress.fromJson(Map<String, dynamic>? json) => OrderAddress();

  Map<String, dynamic> toJson() => {};
}

class Products {
  Products({
    this.categories,
    this.subCategories,
    this.orderItems,
    this.id,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.productName,
    this.capition,
    this.categoryId,
    this.subCategoryId,
    this.price,
    this.datasort,
    this.creationDate,
    this.userRole,
    this.userName,
    this.token,
  });

  dynamic categories;
  dynamic subCategories;
  List<OrderItem>? orderItems;
  String? id;
  String? img1;
  dynamic img2;
  dynamic img3;
  dynamic img4;
  String? productName;
  String? capition;
  String? categoryId;
  String? subCategoryId;
  int? price;
  dynamic datasort;
  DateTime? creationDate;
  dynamic userRole;
  dynamic userName;
  dynamic token;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        categories: json["categories"],
        subCategories: json["subCategories"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
        id: json["id"],
        img1: json["img1"],
        img2: json["img2"],
        img3: json["img3"],
        img4: json["img4"],
        productName: json["productName"],
        capition: json["capition"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        price: json["price"],
        datasort: json["datasort"],
        creationDate: DateTime.parse(json["creationDate"]),
        userRole: json["userRole"],
        userName: json["userName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "subCategories": subCategories,
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "id": id,
        "img1": img1,
        "img2": img2,
        "img3": img3,
        "img4": img4,
        "productName": productName,
        "capition": capition,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "price": price,
        "datasort": datasort,
        "creationDate": creationDate!.toIso8601String(),
        "userRole": userRole,
        "userName": userName,
        "token": token,
      };
}

class OrderItem {
  OrderItem({
    this.orders,
    this.products,
    this.id,
    this.item,
    this.price,
    this.count,
    this.total,
    this.orderId,
    this.productId,
  });

  dynamic orders;
  Products? products;
  String? id;
  dynamic item;
  int? price;
  int? count;
  int? total;
  String? orderId;
  String? productId;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orders: json["orders"],
        products: json["products"] == null ? null : Products.fromJson(json["products"]),
        id: json["id"] == null ? null : json["id"],
        item: json["item"],
        price: json["price"] == null ? null : json["price"],
        count: json["count"] == null ? null : json["count"],
        total: json["total"] == null ? null : json["total"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        productId: json["productId"] == null ? null : json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "orders": orders,
        "products": products == null ? null : products!.toJson(),
        "id": id == null ? null : id,
        "item": item,
        "price": price == null ? null : price,
        "count": count == null ? null : count,
        "total": total == null ? null : total,
        "orderId": orderId == null ? null : orderId,
        "productId": productId == null ? null : productId,
      };
}
