import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  static const TAG = "AuthController: ";
  final AuthRepositoryBase authRepository;
  AuthController({@required this.authRepository}) {
    // _firstOpen = authRepository.isFirstOpen;
    _myUser = authRepository.myUser;
    _authState = authRepository.authState;
  }

  var _loading = false;
  var _firstOpen = false;
  var _error = "";
  var inputCountryDialCode = "+964"; // default dial code that initialized in the input
  var inputPhoneNumber = "";
  MyUser _myUser;
  AuthState _authState;

  bool get isLoading => _loading;
  bool get firstOpen => _firstOpen;
  bool get hasError => _error.isNotEmpty;
  String get error => _error;
  MyUser get myUser => _myUser;
  AuthState get authState => _authState;

  String get inputPhoneWithCountryCode {
    if (inputPhoneNumber.startsWith(inputCountryDialCode)) {
      // if the user entered the country dial code with the number in the correct format return the user entered value
      return inputPhoneNumber;
    } else if (inputPhoneNumber.startsWith("00964")) {
      // if the user entered the country dial code with the number in the wrong format -starting with 00 is rejected by firebase-
      // delete the wrong code and concatenate the selected code
      final phoneWithoutCode = inputPhoneNumber.substring(5);
      return "$inputCountryDialCode$phoneWithoutCode";
    }
    // otherwise if the user entered the number without dial code concatenate the code with the user entered number
    return "$inputCountryDialCode$inputPhoneNumber";
  }

  onFirstOpenDone() {
    authRepository.isFirstOpen = false;
    updateWith(firstOpen: false);
  }

  Future verifyPhoneNumber(Future onCodeSent) async {
    print("$TAG verifyPhoneNumber: verify with: phoneNumber:$inputPhoneWithCountryCode");
    try {
      if (inputPhoneWithCountryCode == null) throw Exception("couldn't verify phone !");
      updateWith(isLoading: true);
      // trigger the sign in flow and wait for the result
      await authRepository.verifyPhone(
          inputPhoneWithCountryCode, onCodeSent, onVerificationSuccess, onVerificationFailed);
    } catch (error) {
      updateWith(isLoading: false, error: error.toString());
      print("$TAG [Error]: $error");
    }
  }

  Future onVerificationSuccess(UserCredential credential, String phoneNumber) async {
    print("$TAG signIn: signIn with: phoneNumber:$phoneNumber");
    try {
      updateWith(isLoading: true);
      // trigger the sign in flow and wait for the result
      // final result = await authRepository.verifyPhone(phoneNumber, onCodeSent);
      print("$TAG signIn: result:$credential");
      if (credential != null) {
        // store both userId and phone number so we can use them
        // -even if the user closed the app-
        // for the creating new profile if not exist
        authRepository.userId = credential.user.uid;
        authRepository.phoneNumber = phoneNumber;
        print("$TAG signIn: authRepository.userId:${authRepository.userId}");
        print("$TAG signIn: authRepository.phoneNumber:${authRepository.phoneNumber}");

        // try to get the user profile to update the current auth state
        final profile = await authRepository.fetchUserProfile().catchError((error) {
          print("$TAG fetchUserProfile: ${error.toString()}");
        });
        print("$TAG signIn: profile:$profile");
        if (profile == null) {
          // the user has no account but their phone verified and we obtained the generated userId
          authRepository.authState = AuthState.PHONE_VERIFIED;
        } else {
          // the user already has an account update the auth state to redirect to home screen
          authRepository.authState = AuthState.LOGGED_IN;
          authRepository.myUser = profile;
        }
      }
      print("$TAG signIn: authRepository.authState:${authRepository.authState}");
      print("$TAG signIn: authRepository.myUser:${authRepository.myUser}");
      updateWith(isLoading: false, authState: authRepository.authState, myUser: authRepository.myUser);
    } catch (error) {
      updateWith(isLoading: false, error: error.toString());
      print("$TAG [Error]: $error");
    }
  }

  Future createUserProfile(String name, String phoneNumber, String birthDate, String email) async {
    try {
      updateWith(isLoading: true);
      final request = MyUser(
        userId: authRepository.userId,
        phoneNumber: phoneNumber,
        userName: name,
        dateBirth: birthDate,
        email: email,
      );
      final result = await authRepository.createUserProfile(request);
      if (result != null) {
        // todo check the needed return type
        final user = await authRepository.fetchUserProfile();
        if (user != null) {
          _myUser = user;
          authRepository.authState = AuthState.LOGGED_IN;
        }
      }
      updateWith(isLoading: false, authState: authRepository.authState);
    } catch (error) {
      updateWith(isLoading: false, error: error.toString());
      print("$TAG [Error]: $error");
    }
  }

  void onVerificationFailed(Exception e) {
    updateWith(isLoading: false, error: e.toString());
  }

  void logout() async {
    await authRepository.logout();
    updateWith(
      myUser: authRepository.myUser,
      authState: authRepository.authState,
    );
  }

  void onErrorHandled() {
    _error = "";
  }

  void updateWith({
    bool isLoading,
    String error,
    bool firstOpen,
    MyUser myUser,
    AuthState authState,
  }) {
    this._loading = isLoading ?? this._loading;
    this._error = error ?? this._error;
    this._firstOpen = firstOpen ?? this._firstOpen;
    this._myUser = myUser ?? this._myUser;
    this._authState = authState ?? this._authState;
    notifyListeners();
  }
}
