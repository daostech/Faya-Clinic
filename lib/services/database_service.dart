import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faya_clinic/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBService {
  static const TAG = "DBService:";

  static const _COL_USERS = "users";

  final _dbRef = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<dynamic> addUserNotificationToken(String token) async {
    final uid = _auth.currentUser.uid;
    print("$TAG adding new token ${token.substring(0, 10)}... for user: $uid..");
    List<dynamic> tokens = [];
    // get the user old tokens list
    await _dbRef
        .collection(_COL_USERS)
        .doc(uid)
        .get()
        .then((value) => tokens = value.get("notification_tokens"))
        .catchError((error) {
      print("$TAG [Error] addUserNotificationToken:: $error");
    });
    final existToken = tokens.firstWhere((element) => element == token, orElse: () => null);
    // if the sent token is already exist don't update the tokens list
    if (existToken != null) {
      print("$TAG ignoring the sent token because it is already exist");
      return null;
    }
    print("$TAG addUserNotificationToken: retreived user token list ${token.toString()}");
    tokens.add(token); // add the new token to the old list
    Map<String, dynamic> newTokens = {"notification_tokens": tokens};
    return _dbRef.collection(_COL_USERS).doc(uid).update(newTokens);
  }

  Future<MyUser> createNewUser(MyUser user) async {
    print("$TAG creating new user data..");
    // await _dbRef
    //     .collection(_COL_USERS)
    //     .doc(user.id)
    //     .set(user.toJson())
    //     .then((value) => print("$TAG created new user in db"))
    //     .catchError((error) => print("$TAG [Error] createNewUser:: $error"));

    //create user public profile
    await createUserProfile(user);
    // return the new created user info
    return await getCurrentUser();
  }

  Future<void> createUserProfile(MyUser user) {
    print("$TAG creating user profile..");
    // UserProfile userProfile = UserProfile();
    // return _dbRef
    //     .collection(_COL_USER_PROFILES)
    //     .doc(taksiciUser.id)
    //     .set(userProfile.toJson())
    //     .then((value) => print("$TAG created user profile in db"))
    //     .catchError((error) => print("$TAG [Error] createUserProfile:: $error"));
  }

  Future<MyUser> getUserById(String uId) async {
    print("$TAG getting user data for $uId..");
    MyUser user;
    // await _dbRef
    //     .collection(_COL_USERS)
    //     .doc(uId)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) => {
    //           user = MyUser.fromJson(documentSnapshot.data()),
    //           print("$TAG User ${user.toString()}"),
    //         })
    //     .catchError((error) {
    //   print("$TAG [Error] getUserById:: $error");
    // });
    return user;
  }

  Future<MyUser> getCurrentUser() async {
    final uId = _auth.currentUser.uid;
    print("$TAG getting user data for $uId..");
    MyUser user;
    // await _dbRef
    //     .collection(_COL_USERS)
    //     .doc(uId)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) => {
    //           user = MyUser.fromJson(documentSnapshot.data()),
    //           print("$TAG Taksici User ${user.toString()}"),
    //         })
    //     .catchError((error) {
    //   print("$TAG [Error] getTaksiciUser:: $error");
    // });
    return user;
  }
}
