import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';

class FavoriteProductsController with ChangeNotifier {
  static const TAG = "[FavoriteProductsProvider] ";
  static const ERR = "[Error] ";

  final FavoriteRepositoryBase favoriteRepository;
  FavoriteProductsController({this.favoriteRepository}) {
    _favoriteProducts?.clear();
    _favoriteProducts.addAll(favoriteRepository.allProducts);
  }

  List<Product> _favoriteProducts = [];

  List get favoriteProducts => _favoriteProducts;

  void toggleFavorite(Product product) {
    if (product == null) return;
    if (isFavoriteProduct(product)) {
      _favoriteProducts.removeWhere((element) => element.id == product.id);
    } else
      _favoriteProducts.add(product);
    favoriteRepository.toggleProduct(product);
    notifyListeners();
  }

  bool isFavoriteProduct(Product product) {
    if (product == null) return false;
    return _favoriteProducts.firstWhere((element) => element.id == product.id, orElse: () => null) != null;
  }
}
