import 'package:collection/collection.dart' show IterableExtension;
import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/models/coupon.dart';
import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/storage/local_storage.dart';

abstract class CartRepositoryBase {
  List<OrderItem>? allItems;

  bool addToCart(OrderItem item);
  bool addQuantity(String? id);
  bool removeQuantity(String? id);
  Future<bool> deleteItem(String? id);

  Future<Coupon?> fetchCoupun(String name);
  Future deleteAll();
}

class CartRepository implements CartRepositoryBase {
  final APIService? apiService;
  final LocalStorageService? localStorage;
  CartRepository({this.apiService, this.localStorage});

  @override
  bool addQuantity(String? id) {
    final item = allItems.firstWhereOrNull((element) => element.id == id);
    if (item == null) return false;
    final qnt = item.count;
    if (qnt != null) {
      final newCount = qnt + 1;
      item.count = newCount;
    }
    item.save();
    return qnt != item.count;
  }

  @override
  bool addToCart(OrderItem item) {
    localStorage!.insertObject(item);
    return existItem(item.id);
  }

  @override
  List<OrderItem> get allItems => List<OrderItem>.from(localStorage!.getAll());

  @override
  set allItems(List<OrderItem>? _allItems) {
    localStorage!.insertList(_allItems);
  }

  @override
  Future deleteAll() {
    return localStorage!.clearAll();
  }

  @override
  Future<bool> deleteItem(String? id) async {
    final item = allItems.firstWhereOrNull((element) => element.id == id);
    if (item == null) return false;
    await item.delete();
    // allItems.removeWhere((element) => element.id == id);
    return !existItem(item.id);
  }

  @override
  bool removeQuantity(String? id) {
    final item = allItems.firstWhereOrNull((element) => element.id == id);
    if (item == null || item.count == 1) return false;
    final qnt = item.count;
    if (qnt != null) {
      final newCount = qnt - 1;
      item.count = newCount;
    }
    item.save();
    return qnt != item.count;
  }

  bool existItem(String? id) {
    return allItems.firstWhereOrNull((element) => element.id == id) != null;
  }

  @override
  Future<Coupon?> fetchCoupun(String name) async {
    try {
      final result = await apiService!
          .getObject<Coupon>(builder: (data) => Coupon.fromJson(data), path: APIPath.fetchCoupon(name));
      return result;
    } catch (error) {
      return null;
    }
  }
}
