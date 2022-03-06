import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/repositories/cart_repository.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/models/requests/create_profile_request.dart';
import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/services/auth_service.dart';
import 'package:faya_clinic/storage/local_storage.dart';
import 'package:faya_clinic/extensions/enum.dart';

class AuthState extends AppEnum<String> {
  const AuthState(String val) : super(val);
  static const AuthState LOGGED_IN = const AuthState('loggedIn');
  static const AuthState LOGGED_OUT = const AuthState('loggedOut');
  static const AuthState PHONE_VERIFIED = const AuthState('phoneVerified');
}

abstract class AuthRepositoryBase {
  bool isLoggedIn;
  bool isFirstOpen;
  String userId;
  String phoneNumber;
  AuthState authState;
  MyUser myUser;

  Future verifyPhone(String phoneNumber, Future onCodeSent,
      Function(UserCredential credential, String phone) onPhoneVerified, Function(Exception e) onVerificationFailed);
  Future createUserProfile(CreateUserProfileRequest requestBody);
  Future<MyUser> fetchUserProfile();
  Future<bool> updateUserProfile(CreateUserProfileRequest requestBody);
  void logout();
}

class AuthRepository implements AuthRepositoryBase {
  final APIService apiService;
  final AuthBase authService;
  final AddressesRepositoryBase addressesRepository;
  final FavoriteRepositoryBase favoriteRepository;
  final CartRepositoryBase cartRepository;
  final LocalStorageService localStorageService;

  AuthRepository(
      {@required this.addressesRepository,
      @required this.favoriteRepository,
      @required this.cartRepository,
      @required this.authService,
      @required this.localStorageService,
      @required this.apiService});

  @override
  bool get isLoggedIn => localStorageService.getValue(HiveKeys.LOGGED_IN, false);

  @override
  bool get isFirstOpen => localStorageService.getValue(HiveKeys.FIRST_OPEN, true);

  @override
  String get userId => localStorageService.getValue(HiveKeys.USER_ID, null);

  @override
  String get phoneNumber => localStorageService.getValue(HiveKeys.PHONE_NUMBER, null);

  @override
  MyUser get myUser => localStorageService.getValue(HiveKeys.USER_PROFILE, null);

  @override
  AuthState get authState {
    final stateStr = localStorageService.getValue(HiveKeys.AUTH_STATE, "loggedOut");
    return AuthState(stateStr);
  }

  @override
  set isLoggedIn(bool loggedIn) {
    localStorageService.saveValue(HiveKeys.LOGGED_IN, loggedIn);
  }

  @override
  set isFirstOpen(bool firstOpen) {
    localStorageService.saveValue(HiveKeys.FIRST_OPEN, firstOpen);
  }

  @override
  set userId(String userId) {
    localStorageService.saveValue(HiveKeys.USER_ID, userId);
  }

  @override
  set phoneNumber(String phoneNumber) {
    localStorageService.saveValue(HiveKeys.PHONE_NUMBER, phoneNumber);
  }

  @override
  set myUser(MyUser myUser) {
    localStorageService.saveValue(HiveKeys.USER_PROFILE, myUser);
  }

  @override
  set authState(AuthState authState) {
    localStorageService.saveValue(HiveKeys.AUTH_STATE, authState.value);
  }

  @override
  void logout() {
    userId = null;
    phoneNumber = null;
    myUser = null;
    addressesRepository.deleteAll();
    favoriteRepository.deleteAll();
    cartRepository.deleteAll();
    authService.logout();
    authState = AuthState.LOGGED_OUT;
  }

  @override
  Future verifyPhone(String phoneNumber, onCodeSent, Function(UserCredential credential, String phone) onPhoneVerified,
      Function(Exception e) onVerificationFailed) async {
    await authService.signInWithPhone(phoneNumber, onCodeSent, onPhoneVerified, onVerificationFailed);
  }

  @override
  Future createUserProfile(CreateUserProfileRequest requestBody) {
    return apiService.postData(path: APIPath.createUser(), body: requestBody.toJson());
  }

  @override
  Future<MyUser> fetchUserProfile() async {
    final userData =
        await apiService.getObject<MyUser>(builder: (data) => MyUser.fromJson(data), path: APIPath.userProfile(userId));
    myUser = userData;
    return myUser;
  }

  @override
  Future<bool> updateUserProfile(CreateUserProfileRequest requestBody) async {
    final response = await apiService.postData(path: APIPath.createUser(), body: requestBody.toJson());
    if (response.success) {
      // if the update done re fetch the user data and store it in the local
      myUser = await fetchUserProfile();
    }
    return response.success;
  }
}
