import 'package:faya_clinic/common/listable.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class SearchController with ChangeNotifier {
  static const TAG = "AuthController: ";
  final Database database;
  bool _isLoading = true;
  List<ListAble> _items;
  List<ListAble> _result;

  SearchController(this.database);

  List<ListAble> get items => _items;
  List<ListAble> get result => _result;

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

  Future<List<ListAble>> onSearch(String keyword) async {
    if (keyword.isEmpty) {
      // updateWith(result: <ListAble>[]);
      return <ListAble>[];
    }
    var result = <ListAble>[];
    if (items == null) {
      _items = await _fetchData();
    }
    _items.forEach((element) {
      if (element.containsKeyword(keyword)) {
        result.add(element);
      }
    });
    return result;
  }

  appendItems(List<ListAble> items) {
    _items.addAll(items);
    notifyListeners();
  }

  updateWith({bool loading, List<ListAble> items, List<ListAble> result}) {
    _isLoading = loading ?? this._isLoading;
    _items = items ?? this._items;
    _result = result ?? this._result;
    notifyListeners();
  }
}
