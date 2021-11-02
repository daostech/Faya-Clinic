import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  static const TAG = "AuthService:";

  final _auth = FirebaseAuth.instance;
  final _fcm = FirebaseMessaging.instance;
  final _dbService = new DBService();

  bool _isLoading;
  bool _isLoggedIn;

  AuthService() {
    print("$TAG invoked const");
    _isLoading = false;
    _isLoggedIn = _auth.currentUser != null;
  }

  bool get isLoading => _isLoading;

  bool get isLoggedIn => _isLoggedIn;

  set isLoading(bool isLoading) {
    this._isLoading = isLoading;
    notifyListeners();
  }

  set isLoggedIn(bool isLoggedIn) {
    this._isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  Stream<User> get authChangeStream {
    return _auth.authStateChanges();
  }

  /// get the device token to add it to the user data
  /// called on new sign in session
  Future<void> _addCurrentDeviceToken() async {
    print("$TAG addCurrentDeviceToken: adding current fcm token to user tokens list");
    final token = await _fcm.getToken();
    return _dbService.addUserNotificationToken(token);
  }

  Future<MyUser> _getTUserOrCreateIfNotExist() async {
    //since this method triggered for providers in both login and sign up DO
    // => check first if this user is exist to avoid overwriting any old data
    MyUser _user = await _dbService.getUserById(_auth.currentUser?.uid);

    // => if there is no exist user linked with the current user id
    // => create new user data with new Id and push the data to server
    if (_user == null) {
      final _newUserFromCred = await _createNewUserWithCurrentCredentials();
      _user = await _dbService.createNewUser(_newUserFromCred);
    }
    return _user;
  }

  ///returns new User instance from the current user credentials
  Future<MyUser> _createNewUserWithCurrentCredentials() async {
    print('$TAG creating new user from current credentials for ${_auth.currentUser.email}');

    final token = await _fcm.getToken();
    List<String> tokens = [token];
    // return MyUser(
    //   id: _auth.currentUser?.uid,
    //   tid: tId,
    //   displayName: tId,
    //   //set the display name as the id and let user change it later
    //   email: _auth.currentUser.email,
    //   phoneNumber: _auth.currentUser.phoneNumber,
    //   avatar: _auth.currentUser.photoURL,
    //   tc: "",
    //   tcVerified: false,
    //   linkedProviders: [],
    //   notificationTokens: tokens,
    // );
  }

  Future<MyUser> signInWithPhone(String number, Function onCodeSent) async {
    try {
      print("$TAG signing in with $number");
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        //codeAutoRetrievalTimeout
        // timeout The maximum amount of time you are willing to wait for SMS auto-retrieval
        // to be completed by the library. Maximum allowed value is 2 minutes.
        timeout: const Duration(seconds: 60),

        //verificationCompleted callback
        // On some Android devices, auto-verification can be handled by the device
        // and a PhoneAuthCredential will be automatically provided.
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("$TAG verification completed");
          await _auth.signInWithCredential(credential);

          //since signInWithPhone triggered in both login and sign up
          //check if the user exist get their data otherwise create new user
          final _user = await _getTUserOrCreateIfNotExist();

          print("$TAG logged in as  $number !");
          //return either the exist user or the new created one
          return _user;
        },
        //verificationFailed callback
        verificationFailed: (FirebaseAuthException e) {
          print("$TAG verificationFailed");
          print('$TAG $e');
          // throw MyException.firebaseAuthException(e);
        },
        //codeSent callback
        codeSent: (String verificationId, int resendToken) async {
          print("$TAG codeSent");
          print("$TAG verificationId : $verificationId");
          print("$TAG resendToken : $resendToken");

          //wait for the result that sent form PromptVerifyCode and store
          //it to smsCode to open new session with phone credential
          final smsCode = await onCodeSent();

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(phoneAuthCredential);

          //since signInWithPhone triggered in both login and sign up
          //check if the user exist get their data otherwise create new user
          final _user = await _getTUserOrCreateIfNotExist();

          await _addCurrentDeviceToken(); // add the current device token to the user tokens list

          print("$TAG logged in as  $number !");
          //return either the exist user or the new created one
          return _user;
        },
        //codeAutoRetrievalTimeout callback
        codeAutoRetrievalTimeout: (String verificationId) {
          print("$TAG codeAutoRetrievalTimeout");
          print("$TAG verificationId : $verificationId");
        },
      );
      return null;
    } on FirebaseAuthException catch (e) {
      // throw MyException.firebaseAuthException(e);
    } catch (e) {
      print('$TAG $e');
      // throw MyException(e);
    }
  }

  Future<void> logout() async {
    try {
      print('$TAG logging out..');
      await _auth.signOut();

      //update login state so user state triggered and update its data
      isLoggedIn = _auth.currentUser != null;
      //reset the user type to ensure the default value is set
      //to avoid any problem if the user try to create new account
      //from the home page after signing out from a driver account
      print('$TAG signed out successfully');
    } catch (e) {
      print('$TAG $e');
      // throw MyException(e);
    }
  }
}
