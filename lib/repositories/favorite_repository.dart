import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/storage/local_storage.dart';

abstract class FavoriteRepositoryBase {
  List<Product> get allProducts;
  addProduct(Product product);
  deleteProduct(Product product);
  toggleProduct(Product product);
  deleteAll();
  saveProductList(List<Product> products);

  bool isFavorite(Product product);
}

class FavoriteRepository implements FavoriteRepositoryBase {
  final LocalStorageService localStorage;
  FavoriteRepository(this.localStorage);

  @override
  List<Product> get allProducts => List<Product>.from(localStorage.getAll()) ?? [];

  @override
  addProduct(Product product) {
    print("FavoriteRepository: added ${product.toJson()}");
    localStorage.insertObject(product);
    // localStorage.saveValue(product.id, product);
  }

  @override
  deleteAll() {
    localStorage.clearAll();
  }

  @override
  deleteProduct(Product product) {
    localStorage.deleteObject(product);
  }

  @override
  saveProductList(List<Product> products) {
    localStorage.insertList(products);
  }

  @override
  bool isFavorite(Product product) {
    print("FavoriteRepository: isFavorite ${product.toJson()}");
    return allProducts.firstWhere((element) => element.id == product.id, orElse: () => null) != null;
  }

  @override
  toggleProduct(Product product) {
    if (isFavorite(product)) {
      deleteProduct(product);
    } else {
      addProduct(product);
    }
  }
}
