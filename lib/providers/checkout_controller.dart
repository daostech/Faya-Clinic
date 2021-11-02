import 'package:faya_clinic/models/payment_method.dart';
import 'package:faya_clinic/models/shipping_method.dart';
import 'package:faya_clinic/screens/checkout/tap_address.dart';
import 'package:faya_clinic/screens/checkout/tap_payment.dart';
import 'package:faya_clinic/screens/checkout/tap_review.dart';
import 'package:faya_clinic/screens/checkout/tap_shipping.dart';
import 'package:flutter/material.dart';

class CheckoutController with ChangeNotifier {
  static const TAG = "[CheckoutController] ";
  static const ERR = "[Error] ";

  final _tabs = [
    CheckoutAddressTap(),
    CheckoutShippingTap(),
    CheckoutReviewTap(),
    CheckoutPaymentTap(),
  ];

  var _currentTabIndex = 0;
  ShippingMethod _shippingMethod;
  PaymentMethod _paymentMethod;

  int get currentTabIndex => _currentTabIndex;
  Widget get currentTab => _tabs[_currentTabIndex];
  ShippingMethod get shippingMethod => _shippingMethod;
  PaymentMethod get paymentMethod => _paymentMethod;

  set currentTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  set shippingMethod(ShippingMethod method) {
    _shippingMethod = method;
    notifyListeners();
  }

  set paymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    notifyListeners();
  }

  void nextTab() {
    if (_currentTabIndex < 3) _currentTabIndex++;
    notifyListeners();
  }

  void previousTab() {
    if (_currentTabIndex > 0) _currentTabIndex--;
    notifyListeners();
  }
}
