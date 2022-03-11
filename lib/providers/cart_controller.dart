import 'package:faya_clinic/models/coupon.dart';
import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/repositories/cart_repository.dart';
import 'package:flutter/material.dart';

class CartController with ChangeNotifier {
  static const TAG = "[CartController] ";
  static const ERR = "[Error] ";

  final coupunTxtController = TextEditingController();
  final CartRepositoryBase cartRepository;
  List<OrderItem> allItems = [];
  Coupon appliedCoupon;

  var productCount = 0;

  var _cartPrice = 0.0;
  var _error = "";
  var _isLoading = false;

  CartController({@required this.cartRepository}) {
    allItems = cartRepository.allItems;
    _cartPrice = totalPrice;
  }

  int get count => allItems?.length ?? 0;
  bool get isCartEmpty => allItems.length == 0;
  bool get hasError => _error.isNotEmpty;
  bool get isLoading => _isLoading;
  bool get hasCoupun => appliedCoupon != null;
  String get error => _error;

  double get totalPrice {
    if (allItems == null || allItems.isEmpty) return 0.0;
    var price = 0.0;
    for (OrderItem item in allItems) {
      price += item.price * item.count;
    }
    // if the applied coupon is not null subtract the coupon discount value from the total
    if (appliedCoupon != null) price -= appliedCoupon.discountValue ?? 0;
    return price;
  }

  bool addToCart(Product product) {
    if (existProduct(product.id)) return false;
    final item = OrderItem(
      id: product.id,
      count: 1,
      name: product.name,
      image: product.img1,
      price: product.price,
    );
    allItems.add(item);
    cartRepository.addToCart(item);
    update(count: allItems.length, price: totalPrice, items: cartRepository.allItems);
    return true;
  }

  int addQTY(String id) {
    cartRepository.addQuantity(id);
    allItems = cartRepository.allItems;
    update(price: totalPrice, items: cartRepository.allItems);
    return count;
  }

  int removeQTY(String id) {
    var qty = itemQTY(id);
    if (qty > 1)
      qty = allItems.firstWhere((order) => order.id == id, orElse: () => null)?.count--;
    else
      qty = -1;
    cartRepository.removeQuantity(id);
    update(price: totalPrice, items: cartRepository.allItems);
    return qty;
  }

  int itemQTY(String id) {
    return allItems.firstWhere((order) => order.id == id, orElse: () => null)?.count ?? 0;
  }

  double itemTotalPrice(String id) {
    return allItems.firstWhere((order) => order.id == id, orElse: () => null)?.totalPrice ?? 0;
  }

  bool existProduct(String id) {
    return allItems.firstWhere((order) => order.id == id, orElse: () => null) != null;
  }

  void checkCuopon() async {
    update(isLoading: true, error: "");
    final coupon = await cartRepository.fetchCoupun(coupunTxtController.text);
    if (coupon != null) {
      _cartPrice -= (coupon.discountValue ?? 0);
      update(
        appliedCoupon: coupon,
        isLoading: false,
      );
    } else {
      update(error: "error_not_valid_coupun", isLoading: false);
    }
    print("coupon null ${coupon == null} error: $error name: ${coupunTxtController.text}");
  }

  void deleteCuopon() {
    print("deleteCuopon called");
    coupunTxtController.text = "";
    appliedCoupon = null;
    notifyListeners();
  }

  void deleteProduct(String id) {
    allItems.removeWhere((order) => order.id == id);
    cartRepository.deleteItem(id);
  }

  void clearCart() {
    allItems.clear();
    cartRepository.deleteAll();
    update(items: allItems);
  }

  void update({
    List<OrderItem> items,
    int count,
    double price,
    String error,
    bool isLoading,
    Coupon appliedCoupon,
  }) {
    this.allItems = items ?? this.allItems;
    this.productCount = count ?? this.productCount;
    this._cartPrice = price ?? this._cartPrice;
    this._error = error ?? this._error;
    this.appliedCoupon = appliedCoupon ?? this.appliedCoupon;
    this._isLoading = isLoading ?? this._isLoading;
    notifyListeners();
  }
}
