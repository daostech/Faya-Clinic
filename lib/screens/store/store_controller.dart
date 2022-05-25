import 'package:faya_clinic/models/category.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class StoreController with ChangeNotifier {
  static const TAG = "StoreController: ";
  final Database database;
  final FavoriteRepositoryBase favoriteRepository;
  StoreController({@required this.favoriteRepository, @required this.database}) {
    print("StoreController: constructor");
    init();
  }

  static List<Product> _newArrivals;
  static List<Product> _allProducts;
  static List<Product> _filteredProductsList;
  static List<Category> _categories;
  static List<Category> _selectedCategories = [];
  static List<Product> _favoriteProducts = [];

  bool _isLoading = true;
  bool _mounted = true;
  bool get mounted => _mounted;

  List<Product> get allProducts => _allProducts == null ? null : [..._allProducts];
  List<Product> get newArrivals => _newArrivals == null ? null : [..._newArrivals];
  List<Product> get filteredProductsList => _filteredProductsList == null ? null : [..._filteredProductsList];
  List<Category> get categories => _categories == null ? null : [..._categories];
  bool get isLoading => _isLoading;

  void init() async {
    _favoriteProducts?.clear();
    _favoriteProducts.addAll(favoriteRepository.allProducts);
    await fetchAllProducts();
    await fetchNewArrivalsProducts();
    await fetchAllCategories();
    updateWith(loading: false);
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

  Future<void> fetchAllProducts() async {
    updateWith(loading: true);
    print("$TAG fetchAllProducts: called");
    // if (_allProducts != null) return _allProducts;
    final result = await database.fetchProductsList().catchError((error) {
      print("$TAG [Error] fetchAllProducts : $error");
    });
    _filteredProductsList = [...result];
    updateWith(allProducts: result, loading: false);
  }

  Future<void> fetchNewArrivalsProducts() async {
    updateWith(loading: true);
    print("$TAG fetchNewArrivalsProducts: called");
    // todo change the request or filter to get only new arraivals
    // final result = await database.fetchProductsList().catchError((error) {
    //   print("$TAG [Error] fetchNewArrivalsProducts : $error");
    // });
    // no endpoint for the new arrivals get the product and get the last 10 products
    final sorted = <Product>[..._allProducts];
    final newArrivals = <Product>[];
    sorted.sort((b, a) => a.creationDate.compareTo(b.creationDate));
    if (sorted.length > 10) {
      newArrivals.addAll(sorted.sublist(0, 10));
    } else {
      newArrivals.addAll(sorted);
    }

    updateWith(newArrivals: newArrivals, loading: false);
  }

  Future<void> fetchAllCategories() async {
    updateWith(loading: true);
    print("$TAG fetchAllCategories: called");
    final result = await database.fetchProductCategories().catchError((error) {
      print("$TAG [Error] fetchAllCategories : $error");
    });
    updateWith(categories: result, loading: false);
  }

  bool isSelectedCategory(Category category) {
    if (_selectedCategories == null || _selectedCategories.isEmpty) return false;
    return _selectedCategories.firstWhere((element) => element.id == category.id, orElse: () => null) != null;
  }

  void toggleCategory(Category category) {
    if (isSelectedCategory(category)) {
      _selectedCategories.removeWhere((cat) => cat.id == category.id);
    } else {
      _selectedCategories.add(category);
    }
    updateWith(selectedCategories: _selectedCategories);
    filterProduct();
  }

  void filterProduct() {
    _filteredProductsList.clear();
    if (_selectedCategories.isEmpty) {
      _filteredProductsList.addAll(_allProducts);
    } else {
      final selectedCategoreyIDs = _selectedCategories.map((e) => e.id).toList();
      _allProducts.forEach((product) {
        // if (category.id == product.categoryId) _filteredProductsList.add(product);
        if (selectedCategoreyIDs.contains(product.categoryId)) _filteredProductsList.add(product);
      });
    }
    print("filtered: selectedCategories size = ${_selectedCategories.length}");
    print("filtered: filteredProductsList size = ${_filteredProductsList.length}");
    updateWith(filteredProducts: _filteredProductsList);
  }

  bool isFavoriteProduct(Product product) {
    if (product == null) return false;
    return _favoriteProducts.firstWhere((element) => element.id == product.id, orElse: () => null) != null;
  }

  void updateWith({
    bool loading,
    List<Product> allProducts,
    List<Product> newArrivals,
    List<Product> filteredProducts,
    List<Category> selectedCategories,
    List<Category> categories,
  }) {
    _isLoading = loading ?? _isLoading;
    _allProducts = allProducts ?? _allProducts;
    _newArrivals = newArrivals ?? _newArrivals;
    _categories = categories ?? _categories;
    _selectedCategories = selectedCategories ?? _selectedCategories;
    _filteredProductsList = filteredProducts ?? _filteredProductsList;
    if (mounted) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
