import 'dart:convert';

import 'package:faya_clinic/models/response/post_response.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/repositories/cart_repository.dart';
import 'package:faya_clinic/repositories/favorite_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/models/user.dart';
import 'package:faya_clinic/services/auth_service.dart';
import 'package:faya_clinic/storage/local_storage.dart';
import 'package:faya_clinic/extensions/enum.dart';

class AuthState extends AppEnum<String?> {
  const AuthState(String? val) : super(val);
  static const AuthState LOGGED_IN = const AuthState('loggedIn');
  static const AuthState LOGGED_OUT = const AuthState('loggedOut');
  static const AuthState PHONE_VERIFIED = const AuthState('phoneVerified');
}

abstract class AuthRepositoryBase {
  bool? isLoggedIn;
  bool? isFirstOpen;
  String? userId;
  String? phoneNumber;
  String? fcmToken;
  String? chatRoomName;
  AuthState? authState;
  MyUser? myUser;

  Future verifyPhone(String phoneNumber, Future onCodeSent,
      Function(UserCredential? credential, String phone) onPhoneVerified, Function(Exception e) onVerificationFailed);
  Future<PostResponse> createUserProfile(MyUser user);
  Future<MyUser?> fetchUserProfile();
  Future<PostResponse> updateUserProfile(MyUser user);
  Future<void> updateDeviceToken();
  Future logout();
}

class AuthRepository implements AuthRepositoryBase {
  final APIService apiService;
  final AuthBase authService;
  final AddressesRepositoryBase addressesRepository;
  final FavoriteRepositoryBase favoriteRepository;
  final CartRepositoryBase cartRepository;
  final LocalStorageService localStorageService;

  final fcm = FirebaseMessaging.instance;

  AuthRepository({
    required this.addressesRepository,
    required this.favoriteRepository,
    required this.cartRepository,
    required this.authService,
    required this.localStorageService,
    required this.apiService,
  });

  @override
  bool? get isLoggedIn => localStorageService.getValue(HiveKeys.LOGGED_IN, false);

  @override
  bool? get isFirstOpen => localStorageService.getValue(HiveKeys.FIRST_OPEN, true);

  @override
  String? get userId => localStorageService.getValue(HiveKeys.USER_ID, null);

  @override
  String? get phoneNumber => localStorageService.getValue(HiveKeys.PHONE_NUMBER, null);

  @override
  String? get fcmToken => localStorageService.getValue(HiveKeys.FCM_TOKEN, null);

  @override
  String? get chatRoomName => localStorageService.getValue(HiveKeys.CHAT_ROOM_NAME, null);

  @override
  MyUser? get myUser => localStorageService.getValue(HiveKeys.USER_PROFILE, null);

  @override
  AuthState get authState {
    final stateStr = localStorageService.getValue(HiveKeys.AUTH_STATE, "loggedOut");
    return AuthState(stateStr);
  }

  @override
  set isLoggedIn(bool? loggedIn) {
    localStorageService.saveValue(HiveKeys.LOGGED_IN, loggedIn);
  }

  @override
  set isFirstOpen(bool? firstOpen) {
    localStorageService.saveValue(HiveKeys.FIRST_OPEN, firstOpen);
  }

  @override
  set userId(String? userId) {
    localStorageService.saveValue(HiveKeys.USER_ID, userId);
  }

  @override
  set phoneNumber(String? phoneNumber) {
    localStorageService.saveValue(HiveKeys.PHONE_NUMBER, phoneNumber);
  }

  @override
  set fcmToken(String? fcmToken) {
    localStorageService.saveValue(HiveKeys.FCM_TOKEN, fcmToken);
  }

  @override
  set chatRoomName(String? roomName) {
    print("AuthRepo set chatRoomName: $roomName");
    localStorageService.saveValue(HiveKeys.CHAT_ROOM_NAME, roomName);
  }

  @override
  set myUser(MyUser? myUser) {
    localStorageService.saveValue(HiveKeys.USER_PROFILE, myUser);
  }

  @override
  set authState(AuthState? authState) {
    localStorageService.saveValue(HiveKeys.AUTH_STATE, authState?.value);
  }

  @override
  Future logout() async {
    try {
      userId = null;
      phoneNumber = null;
      chatRoomName = null;
      myUser = null;
      await addressesRepository.deleteAll();
      await favoriteRepository.deleteAll();
      await cartRepository.deleteAll();
      await authService.logout();
      await fcm.deleteToken();
      authState = AuthState.LOGGED_OUT;
    } catch (error) {
      print("AuthRepository logout $error");
    }
  }

  @override
  Future verifyPhone(String phoneNumber, onCodeSent, Function(UserCredential? credential, String phone) onPhoneVerified,
      Function(Exception e) onVerificationFailed) async {
    await authService.signInWithPhone(phoneNumber, onCodeSent, onPhoneVerified, onVerificationFailed);
  }

  @override
  Future<PostResponse> createUserProfile(MyUser user) async {
    fcmToken = await fcm.getToken();
    final request = user.copyWith(token: fcmToken);
    print("createUserProfile request: ${request.toJson()}");
    return apiService.postData(path: APIPath.createUser(), body: request.toJson());
  }

  @override
  Future<MyUser?> fetchUserProfile() async {
    final userData = await apiService.getObject<MyUser>(
      builder: (data) => MyUser.fromJson(data),
      path: APIPath.getUserProfile(userId),
    );
    myUser = userData;
    return myUser;
  }

  @override
  Future<PostResponse> updateUserProfile(MyUser user) async {
    final newUser = myUser!.copyFrom(user: user);
    print("updateUserProfile requestBody ${newUser.toJson()}");
    final response = await apiService.putObject(path: APIPath.updateUserProfile(userId), body: newUser.toJson());
    if (response.success) {
      myUser = await fetchUserProfile();
    }
    return response;
  }

  @override
  Future<void> updateDeviceToken() async {
    final token = await fcm.getToken().catchError((error) {
      print("updateDeviceToken: ${error.toString()}");
    });
    print("updateDeviceToken token $token");
    if (token != fcmToken) {
      // if the exist token not equals to the saved one update it in both local and server
      print("updateDeviceToken updating token $token");
      fcmToken = token;
      final requestBody = myUser!.copyWith(token: fcmToken);
      // final requestBody = MyUser(token: fcmToken);
      print("updateDeviceToken requestBody encode ${json.encode(requestBody)}");
      final result = await updateUserProfile(requestBody);
      print("updateDeviceToken result success ${result.success}");
      print("updateDeviceToken result value ${result.value}");
      print("updateDeviceToken result ${result.toString()}");
    }
  }
}
