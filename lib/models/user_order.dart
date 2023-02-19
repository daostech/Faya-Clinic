import 'dart:convert';

import 'package:faya_clinic/constants/config.dart';

List<UserOrder> userOrderResopnseFromJson(String str) =>
    List<UserOrder>.from(json.decode(str).map((x) => UserOrder.fromJson(x)));

String userOrderResopnseToJson(List<UserOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserOrder {
  UserOrder({
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
  double? total;
  String? paymentMethod;
  String? paymentPrice;
  DateTime? creationDate;
  dynamic productNames;
  dynamic productIds;

  factory UserOrder.fromJson(Map<String, dynamic> json) => UserOrder(
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
  OrderAddress({
    this.orders,
    this.id,
    this.label,
    this.city,
    this.country,
    this.apartment,
    this.street,
    this.block,
    this.zipCode,
    this.orderId,
  });

  dynamic orders;
  String? id;
  String? label;
  String? city;
  String? country;
  String? apartment;
  String? street;
  String? block;
  String? zipCode;
  String? orderId;

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
        orders: json["orders"],
        id: json["id"],
        label: json["label"],
        city: json["city"],
        country: json["country"],
        apartment: json["apartment"],
        street: json["street"],
        block: json["block"],
        zipCode: json["zipCode"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "orders": orders,
        "id": id,
        "label": label,
        "city": city,
        "country": country,
        "apartment": apartment,
        "street": street,
        "block": block,
        "zipCode": zipCode,
        "orderId": orderId,
      };
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
  String? img2;
  String? img3;
  String? img4;
  String? productName;
  String? capition;
  String? categoryId;
  dynamic subCategoryId;
  double? price;
  dynamic datasort;
  DateTime? creationDate;
  dynamic userRole;
  dynamic userName;
  dynamic token;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String _imageUrl(String? img) => "${AppConfig.RAW_BASE_URL}/$img";

  List<String> get images {
    List<String?> tmps = [img1, img2, img3];
    List<String> imgs = [];
    for (int i = 0; i < 3; i++) {
      if (tmps[i] != null) imgs.add(_imageUrl(tmps[i]));
    }
    return imgs;
  }

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
    this.product,
    this.id,
    this.item,
    this.price,
    this.count,
    this.total,
    this.orderId,
    this.productId,
  });

  dynamic orders;
  Products? product;
  String? id;
  dynamic item;
  double? price;
  double? count;
  double? total;
  String? orderId;
  String? productId;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orders: json["orders"],
        product: json["products"] == null ? null : Products.fromJson(json["products"]),
        id: json["id"],
        item: json["item"],
        price: json["price"],
        count: json["count"],
        total: json["total"],
        orderId: json["orderId"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "orders": orders,
        "products": product == null ? null : product!.toJson(),
        "id": id,
        "item": item,
        "price": price,
        "count": count,
        "total": total,
        "orderId": orderId,
        "productId": productId,
      };
}
