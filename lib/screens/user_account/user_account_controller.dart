import 'dart:convert';
import 'dart:io';

import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserAccountController with ChangeNotifier {
  final AuthRepositoryBase authRepository;
  UserAccountController({required this.authRepository}) {
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
  bool get loading => _loading;
  MyUser? get user => _user;

  MyUser? _user;

  bool get hasUpdates {
    return userNameTxtController.text != _user!.userName ||
        emailTxtController.text != _user!.email ||
        phoneTxtController.text != _user!.phoneNumber;
  }

  MyUser get newUserData => MyUser(
        userName: userNameTxtController.text,
        phoneNumber: phoneTxtController.text,
        email: emailTxtController.text,
      );

  void initForm() {
    userNameTxtController.text = _user!.userName!;
    emailTxtController.text = _user!.email!;
    phoneTxtController.text = _user!.phoneNumber!;
  }

  Future<bool> submitForm() async {
    print("submitForm called");
    if (formKey.currentState!.validate()) {
      if (!hasUpdates) {
        // Navigator.of(context).pop();
        return false;
      } else {
        try {
          final request = MyUser(
            userId: _user!.userId,
            userName: userNameTxtController.text,
            email: emailTxtController.text,
            phoneNumber: _user!.phoneNumber,
            dateBirth: _user!.dateBirth,
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

  uploadNewImage(XFile file) async {
    print("uploadNewImage called");
    if (file == null) return;
    try {
      print("uploadNewImage try");
      final destination = 'userImages/';
      final _photo = File(file.path);

      updateWith(isLoading: true);
      final ref = FirebaseStorage.instance.ref(destination).child('${authRepository.userId}');

      final uploadResult = await ref.putFile(_photo);

      if (uploadResult != null) {
        print("uploadNewImage uploadResult != null");
        final imgUrl = await uploadResult.ref.getDownloadURL();
        final request = MyUser(
          imgUrl: imgUrl,
        );
        print("uploadNewImage requestBody encode ${json.encode(request)}");
        await authRepository.updateUserProfile(request);
      }
      updateWith(isLoading: false, user: authRepository.myUser);
    } catch (e) {
      print('error occured $e');
      updateWith(isLoading: false, error: e.toString());
    }
  }

  void onErrorHandled() {
    _error = "";
  }

  void updateWith({
    bool? isLoading,
    String? error,
    MyUser? user,
  }) {
    this._loading = isLoading ?? this._loading;
    this._error = error ?? this._error;
    this._user = user ?? this._user;
    notifyListeners();
  }
}
