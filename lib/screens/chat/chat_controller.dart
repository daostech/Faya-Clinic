import 'package:faya_clinic/common/listable.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class ChatController with ChangeNotifier {
  static const TAG = "AuthController: ";
  final Database database;
  final AuthRepositoryBase authRepository;
  bool _isLoading = true;

  final messageTxtController = TextEditingController();
  ChatController({this.database, this.authRepository});

  bool get isLoading => _isLoading;

  Future<List<ListAble>> _fetchData() async {
    // updateWith(loading: true);
    var allItems = <ListAble>[];
    try {
      final products = await database.fetchProductsList();
      allItems.addAll(products);
      final sections = await database.fetchSectionsList();
      allItems.addAll(sections);
      final offers = await database.fetchOffersList();
      allItems.addAll(offers);
      // appendItems(products);
      // return products;
      // todo check whether any items gonna be added later
    } catch (error) {}
    return allItems;
  }

  updateWith({bool loading, List<ListAble> items, List<ListAble> result}) {
    _isLoading = loading ?? this._isLoading;
    notifyListeners();
  }
}
