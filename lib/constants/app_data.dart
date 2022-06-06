import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/models/payment_method.dart';
import 'package:faya_clinic/models/shipping_method.dart';

class AppData {
  static const _CURRENCY = AppConfig.PREFFERED_QURRENCY_UNIT;
  static List<ShippingMethod> shippingMethods = [
    ShippingMethod(id: "1", method: "shipping_free", price: 0.0, unite: "$_CURRENCY"),
    ShippingMethod(id: "2", method: "shipping_flat_rate_basra", price: 5000.0, unite: "$_CURRENCY"),
    ShippingMethod(id: "3", method: "shipping_flat_rate_others", price: 10000.0, unite: "$_CURRENCY"),
    ShippingMethod(id: "4", method: "shipping_local_pick_up", price: 20.0, unite: "$_CURRENCY"),
  ];

  static List<PaymentMethod> paymentMethods = [
    // PaymentMethod(id: "1", method: "payment_direct_bank_transfer", image: ""),
    PaymentMethod(id: "2", method: "payment_cash_on_delivery", image: ""),
    // PaymentMethod(id: "3", method: "payment_credit_bank_card", image: ""),
    // PaymentMethod(id: "1", method: "Razorpay", image: ""),
    // PaymentMethod(id: "1", method: "stripe", image: ""),
  ];
}
