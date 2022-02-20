import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/repositories/cart_repository.dart';
import 'package:faya_clinic/storage/local_storage.dart';
import 'package:flutter/material.dart';

class CartController with ChangeNotifier {
  static const TAG = "[CartController] ";
  static const ERR = "[Error] ";

  CartRepositoryBase cartRepository;
  List<OrderItem> allItems = [];
  String discountCoupon;
  int productCount = 0;
  double cartPrice = 0.0;

  CartController(LocalStorageService localStorage) {
    cartRepository = CartRepository(localStorage);
    allItems = cartRepository.allItems;
    cartPrice = totalPrice;
  }

  int get count => allItems?.length ?? 0;
  bool get isCartEmpty => allItems.length == 0;

  double get totalPrice {
    if (allItems == null || allItems.isEmpty) return 0.0;
    var price = 0.0;
    for (OrderItem item in allItems) {
      price += item.price * item.count;
    }
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
    String discount,
    int count,
    double price,
  }) {
    this.allItems = items ?? this.allItems;
    this.discountCoupon = discount ?? this.discountCoupon;
    this.productCount = count ?? this.productCount;
    this.cartPrice = price ?? this.cartPrice;
    notifyListeners();
  }
}
