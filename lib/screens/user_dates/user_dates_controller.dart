import 'package:faya_clinic/models/user_date/user_date.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:faya_clinic/services/database_service.dart';

class UserDatesController with ChangeNotifier {
  static const TAG = "UserDatesController: ";
  final Database database;
  final AuthRepositoryBase authRepository;
  UserDatesController({this.authRepository, this.database}) {
    init();
  }

  final userDates = <UserDate>[];
  var isLoading = true;

  void init() {
    fetchDateRegistered(authRepository.userId);
  }

  Future<void> fetchDateRegistered(String userId) async {
    updateWith(loading: true);
    print("$TAG fetchDateRegistered: called");
    final result = await database.fetchUserDates(userId).catchError((error) {
      print("$TAG [Error] fetchDateRegistered : $error");
    });
    if (result != null) {
      print("$TAG fetchDateRegistered: result ${result.length}");
      userDates.clear();
      userDates.addAll(result);
    }
    print("$TAG fetchDateRegistered: userDates3 ${userDates.length}");
    updateWith(loading: false);
  }

  updateWith({
    bool loading,
  }) {
    isLoading = loading ?? isLoading;
    notifyListeners();
  }
}
