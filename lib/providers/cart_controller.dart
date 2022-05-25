import 'package:faya_clinic/models/coupon.dart';
import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/repositories/cart_repository.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class CartController with ChangeNotifier {
  static const TAG = "[CartController] ";
  static const ERR = "[Error] ";

  final coupunTxtController = TextEditingController();
  final CartRepositoryBase cartRepository;
  final FavoriteRepositoryBase favoriteRepository;
  final Database database;
  List<OrderItem> allItems = [];
  List<Product> suggestedProducts = <Product>[];
  List<Product> _favoriteProducts = [];
  Coupon appliedCoupon;

  var productCount = 0;

  var _cartPrice = 0.0;
  var _error = "";
  var _isLoading = true;

  CartController({
    @required this.database,
    @required this.cartRepository,
    @required this.favoriteRepository,
  }) {
    allItems = cartRepository.allItems;
    _cartPrice = totalPrice;
    _favoriteProducts?.clear();
    _favoriteProducts.addAll(favoriteRepository.allProducts);
    fetchSuggestedProduct();
  }

  int get count => allItems?.length ?? 0;
  bool get isCartEmpty => allItems.length == 0;
  bool get hasError => _error.isNotEmpty;
  bool get isLoading => _isLoading;
  bool get hasCoupun => appliedCoupon != null;
  String get error => _error;

  Future<void> fetchSuggestedProduct() async {
    update(isLoading: true);
    print("$TAG fetchSuggestedProduct: called");
    final result = await database.fetchProductsList().catchError((error) {
      print("$TAG [Error] fetchSuggestedProduct : $error");
      update(isLoading: false);
    });
    update(suggestedProducts: result, isLoading: false);
  }

  bool isFavoriteProduct(Product product) {
    if (product == null) return false;
    return _favoriteProducts.firstWhere((element) => element.id == product.id, orElse: () => null) != null;
  }

  void toggleFavorite(Product product) {
    print("$TAG toggleFavorite called");
    if (product == null) return;
    if (isFavoriteProduct(product)) {
      _favoriteProducts.removeWhere((element) => element.id == product.id);
    } else
      _favoriteProducts.add(product);
    favoriteRepository.toggleProduct(product);
    notifyListeners();
  }

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

  Future<bool> deleteItem(String id) async {
    print("deleteItem called on $id");
    allItems.removeWhere((element) => element.id == id);
    final result = await cartRepository.deleteItem(id);
    update(price: totalPrice, items: cartRepository.allItems);
    return result;
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
    if (coupunTxtController.text.isEmpty) {
      update(error: "error_empty_field");
      return;
    }
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

  void onOrderCreated() {
    _isLoading = false;
    allItems = <OrderItem>[];
    _cartPrice = 0;
    productCount = 0;
    _error = "";
    appliedCoupon = null;
    notifyListeners();
  }

  void update({
    List<OrderItem> items,
    List<Product> suggestedProducts,
    int count,
    double price,
    String error,
    bool isLoading,
    Coupon appliedCoupon,
  }) {
    this.suggestedProducts = suggestedProducts ?? this.suggestedProducts;
    this.allItems = items ?? this.allItems;
    this.productCount = count ?? this.productCount;
    this._cartPrice = price ?? this._cartPrice;
    this._error = error ?? this._error;
    this.appliedCoupon = appliedCoupon ?? this.appliedCoupon;
    this._isLoading = isLoading ?? this._isLoading;
    notifyListeners();
  }
}
