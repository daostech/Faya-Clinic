import 'package:flutter/material.dart';
import 'package:faya_clinic/services/auth_service.dart';
import 'package:faya_clinic/services/database_service.dart';

class SignInController with ChangeNotifier {
  static const TAG = "SignInController: ";
  SignInController({
    @required this.database,
    @required this.authService,
  });

  final Database database;
  final AuthService authService;

  final formKey = GlobalKey<FormState>();

  var isLoading = false;
  var phoneNumber = "";
  var password = "";
  var smsCode = "";

  void forgotPassword() {
    authService.resetPassword();
  }

  void submitForm(onCodeSent) {
    print("$TAG submitForm: submitted with: phoneNumber:$phoneNumber password:$password");
    if (formKey.currentState.validate()) {
      signIn(onCodeSent);
    }
  }

  Future signIn(onCodeSent) async {
    print("$TAG signIn: signIn with: phoneNumber:$phoneNumber password:$password");
    try {
      updateWith(loading: true);
      await authService.signInWithPhone(phoneNumber, onCodeSent);
      updateWith(loading: false);
    } catch (error) {
      updateWith(loading: false);
      print("$TAG [Error]: $error");
      rethrow;
    }
  }

  Future<bool> existUser() {
    // todo implement existUser
    try {} catch (error) {}
  }

  void updateWith({bool loading}) {
    isLoading = loading ?? isLoading;
    notifyListeners();
  }
}
