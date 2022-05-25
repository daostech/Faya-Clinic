import 'package:faya_clinic/models/order.dart';
import 'package:faya_clinic/models/user_order.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:faya_clinic/services/database_service.dart';

class UserOrderController with ChangeNotifier {
  static const TAG = "UserOrderController: ";
  final Database database;
  final AuthRepositoryBase authRepository;
  UserOrderController({this.authRepository, this.database}) {
    init();
  }

  final userOrders = <UserOrder>[];
  var isLoading = true;

  void init() {
    fetchUserOrders(authRepository.userId);
  }

  Future<void> fetchUserOrders(String userId) async {
    updateWith(loading: true);
    print("$TAG fetchDateRegistered: called");
    final result = await database.fetchUserPreviousOrders(userId).catchError((error) {
      print("$TAG [Error] fetchUserOrders : $error");
    });
    if (result != null) {
      userOrders.clear();
      userOrders.addAll(result);
    }
    updateWith(loading: false);
  }

  updateWith({
    bool loading,
  }) {
    isLoading = loading ?? isLoading;
    notifyListeners();
  }
}
