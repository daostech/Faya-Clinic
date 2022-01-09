import 'package:faya_clinic/models/date_registered.dart';
import 'package:flutter/material.dart';
import 'package:faya_clinic/services/database_service.dart';

class UserDatesController with ChangeNotifier {
  static const TAG = "UserDatesController: ";
  // todo add user repo
  final Database database;
  UserDatesController({this.database}) {
    init();
  }

  List<DateRegistered> userDates;
  var isLoading = true;

  void init() {
    fetchDateRegistered("bbbf3cfa-6d01-4382-91e1-0c20a2adffad"); // !debug
  }

  Future<void> fetchDateRegistered(String userId) async {
    updateWith(loading: true);
    print("$TAG fetchDateRegistered: called");
    final result = await database.fetchUserDates(userId).catchError((error) {
      print("$TAG [Error] fetchDateRegistered : $error");
    });
    updateWith(dates: result, loading: false);
  }

  updateWith({
    bool loading,
    List<DateRegistered> dates,
  }) {
    isLoading = loading ?? isLoading;
    userDates = dates ?? userDates;
    notifyListeners();
  }
}
