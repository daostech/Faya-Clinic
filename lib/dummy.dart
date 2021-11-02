import 'package:faya_clinic/models/payment_method.dart';
import 'package:faya_clinic/models/shipping_method.dart';

class DummyData {
  static List<ShippingMethod> shippingMethods = [
    ShippingMethod(id: "1", method: "Free Shipping", price: 0.0, unite: "\$", priceString: "\$0.0"),
    ShippingMethod(id: "2", method: "Flat Rate", price: 10.0, unite: "\$", priceString: "\$10.0"),
    ShippingMethod(id: "3", method: "Local pickup", price: 20.0, unite: "\$", priceString: "\$20.0"),
  ];

  static List<PaymentMethod> paymentMethods = [
    PaymentMethod(id: "1", method: "Direct bank transfer", image: ""),
    PaymentMethod(id: "1", method: "Cash on delivery", image: ""),
    PaymentMethod(id: "1", method: "PayPal", image: ""),
    PaymentMethod(id: "1", method: "Razorpay", image: ""),
    PaymentMethod(id: "1", method: "stripe", image: ""),
  ];
}
