import 'dart:convert';

import 'package:faya_clinic/extensions/enum.dart';
import 'package:faya_clinic/models/address.dart';
import 'package:faya_clinic/models/order_item.dart';

CreateOrderRequest createOrderRequestFromJson(String str) => CreateOrderRequest.fromJson(json.decode(str));

String createOrderRequestToJson(CreateOrderRequest data) => json.encode(data.toJson());

class OrderStatus extends AppEnum<String> {
  const OrderStatus(String val) : super(val);
  static const OrderStatus PENDING = const OrderStatus('pending');
  static const OrderStatus DELIVERED = const OrderStatus('delivered');
  static const OrderStatus REJECTED = const OrderStatus('rejected');
  static const OrderStatus ON_THE_WAY = const OrderStatus('onTheWay');
  static const OrderStatus APPROVED = const OrderStatus('approved');
}

class CreateOrderRequest {
  CreateOrderRequest({
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
    this.orderAddress,
    this.orderItems,
  });

  String userId;
  String couponId;
  String couponCode;
  String orderCode;
  DateTime date;
  String status;
  String note;
  double total;
  String paymentMethod;
  String paymentPrice;
  Address orderAddress;
  List<OrderItem> orderItems;

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) => CreateOrderRequest(
        userId: json["UserId"],
        couponId: json["CouponId"],
        couponCode: json["CouponCode"],
        orderCode: json["OrderCode"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        status: json["Status"],
        note: json["Note"],
        total: json["Total"],
        paymentMethod: json["PaymentMethod"],
        paymentPrice: json["PaymentPrice"],
        orderAddress: json["OrderAddress"] == null ? null : Address.fromJson(json["OrderAddress"]),
        orderItems: json["OrderItems"] == null
            ? null
            : List<OrderItem>.from(json["OrderItems"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "CouponId": couponId,
        "CouponCode": couponCode,
        "OrderCode": orderCode,
        "Date": date?.toIso8601String(),
        "Status": status,
        "Note": note,
        "Total": total,
        "PaymentMethod": paymentMethod,
        "PaymentPrice": paymentPrice,
        "OrderAddress": orderAddress?.toJsonForOrder(),
        "OrderItems": orderItems == null ? null : orderItems.map((x) => x.toJsonForOrder()).toList(),
      };
}
