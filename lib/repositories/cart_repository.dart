import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/storage/local_storage.dart';

abstract class CartRepositoryBase {
  List<OrderItem> allItems;

  bool addToCart(OrderItem item);
  bool addQuantity(String id);
  bool removeQuantity(String id);
  bool deleteItem(String id);
  bool deleteAll();
}

class CartRepository implements CartRepositoryBase {
  final LocalStorageService localStorage;
  CartRepository(this.localStorage);

  @override
  bool addQuantity(String id) {
    final item = allItems.firstWhere((element) => element.id == id, orElse: () => null);
    if (item == null) return false;
    final qnt = item.count;
    item.count++;
    item.save();
    return qnt != item.count;
  }

  @override
  bool addToCart(OrderItem item) {
    localStorage.insertObject(item);
    return existItem(item.id);
  }

  @override
  List<OrderItem> get allItems => List<OrderItem>.from(localStorage.getAll()) ?? [];

  @override
  set allItems(List<OrderItem> _allItems) {
    localStorage.insertList(_allItems);
  }

  @override
  bool deleteAll() {
    localStorage.clearAll();
    return allItems == null || allItems.length == 0;
  }

  @override
  bool deleteItem(String id) {
    final item = allItems.firstWhere((element) => element.id == id, orElse: () => null);
    if (item == null) return false;
    allItems = allItems..removeWhere((element) => element.id == id);
    return !existItem(item.id);
  }

  @override
  bool removeQuantity(String id) {
    final item = allItems.firstWhere((element) => element.id == id, orElse: () => null);
    if (item == null || item.count == 1) return false;
    final qnt = item.count;
    item.count--;
    item.save();
    return qnt != item.count;
  }

  bool existItem(String id) {
    return allItems.firstWhere((element) => element.id == id, orElse: () => null) != null;
  }
}
