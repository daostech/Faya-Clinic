import 'package:faya_clinic/models/requests/create_profile_request.dart';
import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:flutter/material.dart';

class UserAccountController with ChangeNotifier {
  final AuthRepositoryBase authRepository;
  UserAccountController({@required this.authRepository}) {
    print("UserAccountController called");
    user = authRepository.myUser;
  }

  final formKey = GlobalKey<FormState>();
  final userNameTxtController = TextEditingController();
  final phoneTxtController = TextEditingController();
  final emailTxtController = TextEditingController();

  var _loading = false;
  var _error = "";

  MyUser user;

  bool get hasUpdates {
    return userNameTxtController.text != user.fullName ||
        emailTxtController.text != user.email ||
        phoneTxtController.text != user.phone;
  }

  MyUser get newUserData => MyUser(
        fullName: userNameTxtController.text,
        phone: phoneTxtController.text,
        email: emailTxtController.text,
      );

  void initForm() {
    userNameTxtController.text = user.fullName;
    emailTxtController.text = user.email;
    phoneTxtController.text = user.phone;
  }

  void submitForm(BuildContext context) {
    print("submitForm called");
    if (formKey.currentState.validate()) {
      if (!hasUpdates) {
        Navigator.of(context).pop();
      } else {
        // userRepository.saveUserData(newUserData);
        // user = userRepository.userData;
        try {
          final request = CreateUserProfileRequest();
          authRepository.updateUserProfile(request);
          updateWith(isLoading: false);
        } catch (error) {
          updateWith(isLoading: false, error: error.toString());
        }

        notifyListeners();
        Navigator.of(context).pop();
        DialogUtil.showToastMessage(context, "not working yet !");
      }
    }
  }

  void updateWith({
    bool isLoading,
    String error,
  }) {
    this._loading = isLoading ?? this._loading;
    this._error = error ?? this._error;
    notifyListeners();
  }
}
