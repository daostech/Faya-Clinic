import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/models/coupon.dart';
import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/storage/local_storage.dart';

abstract class CartRepositoryBase {
  List<OrderItem> allItems;

  bool addToCart(OrderItem item);
  bool addQuantity(String id);
  bool removeQuantity(String id);
  Future<bool> deleteItem(String id);

  Future<Coupon> fetchCoupun(String name);
  deleteAll();
}

class CartRepository implements CartRepositoryBase {
  final APIService apiService;
  final LocalStorageService localStorage;
  CartRepository({this.apiService, this.localStorage});

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
  List<OrderItem> get allItems => List<OrderItem>.from(localStorage.getAll()) ?? <OrderItem>[];

  @override
  set allItems(List<OrderItem> _allItems) {
    localStorage.insertList(_allItems);
  }

  @override
  deleteAll() {
    localStorage.clearAll();
  }

  @override
  Future<bool> deleteItem(String id) async {
    final item = allItems.firstWhere((element) => element.id == id, orElse: () => null);
    if (item == null) return false;
    await item.delete();
    // allItems.removeWhere((element) => element.id == id);
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

  @override
  Future<Coupon> fetchCoupun(String name) async {
    try {
      final result =
          await apiService.getObject<Coupon>(builder: (data) => Coupon.fromJson(data), path: APIPath.fetchCoupon(name));
      return result;
    } catch (error) {
      return null;
    }
  }
}
