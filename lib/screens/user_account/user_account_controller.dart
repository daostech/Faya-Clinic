import 'package:faya_clinic/models/requests/create_profile_request.dart';
import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';

class UserAccountController with ChangeNotifier {
  final AuthRepositoryBase authRepository;
  UserAccountController({@required this.authRepository}) {
    print("UserAccountController called");
    _user = authRepository.myUser;
  }

  final formKey = GlobalKey<FormState>();
  final userNameTxtController = TextEditingController();
  final phoneTxtController = TextEditingController();
  final emailTxtController = TextEditingController();

  var _loading = false;
  var _error = "";

  String get error => _error;
  bool get hasError => _error.isNotEmpty;
  MyUser get user => _user;

  MyUser _user;

  bool get hasUpdates {
    return userNameTxtController.text != _user.fullName ||
        emailTxtController.text != _user.email ||
        phoneTxtController.text != _user.phone;
  }

  MyUser get newUserData => MyUser(
        fullName: userNameTxtController.text,
        phone: phoneTxtController.text,
        email: emailTxtController.text,
      );

  void initForm() {
    userNameTxtController.text = _user.fullName;
    emailTxtController.text = _user.email;
    phoneTxtController.text = _user.phone;
  }

  Future<bool> submitForm() async {
    print("submitForm called");
    if (formKey.currentState.validate()) {
      if (!hasUpdates) {
        // Navigator.of(context).pop();
        return false;
      } else {
        try {
          final request = CreateUserProfileRequest(
            userId: _user.id,
            userName: userNameTxtController.text,
            email: emailTxtController.text,
            phoneNumber: _user.phone,
            birthDate: _user.dateBirth,
          );
          final result = await authRepository.updateUserProfile(request);
          if (result.success) {
            // the authRepository will handle updating the user in the local if
            // updating profile done. Just get it from local no need to fetch it again
            updateWith(isLoading: false, user: authRepository.myUser);
            return true;
          } else {
            updateWith(isLoading: false, error: TransUtil.trans("error_updating_profile"));
          }
        } catch (error) {
          updateWith(isLoading: false, error: error.toString());
        }
      }
    }
    return false;
  }

  void onErrorHandled() {
    _error = "";
  }

  void updateWith({
    bool isLoading,
    String error,
    MyUser user,
  }) {
    this._loading = isLoading ?? this._loading;
    this._error = error ?? this._error;
    this._user = user ?? this._user;
    notifyListeners();
  }
}
