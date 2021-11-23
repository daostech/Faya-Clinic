import 'package:faya_clinic/models/product.dart';
import 'package:flutter/material.dart';

class FavoriteProductsProvider with ChangeNotifier {
  static const TAG = "[FavoriteProductsProvider] ";
  static const ERR = "[Error] ";

  List<Product> _favoriteProducts = [];

  List get favoriteProducts => [..._favoriteProducts];

  void _addProduct(Product product) {
    _favoriteProducts.add(product);
  }

  void _deleteProduct(Product product) {
    _favoriteProducts.removeWhere((element) => element.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavoriteProduct(product)) {
      _deleteProduct(product);
    } else {
      _addProduct(product);
    }
    notifyListeners();
  }

  bool isFavoriteProduct(Product product) {
    return _favoriteProducts.contains(product);
  }
}
