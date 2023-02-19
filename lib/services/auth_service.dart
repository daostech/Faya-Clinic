import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Stream get authChangeStream;

  signInWithPhone(String number, Future onCodeSent, Function(UserCredential? credential, String phone) onPhoneVerified,
      Function(Exception e) onVerificationFailed);
  resetPassword();
  logout();
}

class FirebaseAuthService implements AuthBase {
  static const TAG = "AuthService:";

  final _auth = FirebaseAuth.instance;

  @override
  Stream<User?> get authChangeStream {
    return _auth.authStateChanges();
  }

  @override
  Future<dynamic> signInWithPhone(
      String number,
      Future onCodeSent,
      Function(UserCredential? credential, String phone) onPhoneVerified,
      Function(Exception e) onVerificationFailed) async {
    UserCredential? userCredential;
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
          userCredential = await _auth.signInWithCredential(credential).catchError((error) {
            onVerificationFailed(error);
          });
          onPhoneVerified(userCredential, number);
          // return userCredential;
        },
        //verificationFailed callback
        verificationFailed: (FirebaseAuthException e) {
          print("$TAG verificationFailed");
          print('$TAG $e');
          onVerificationFailed(e);
          // throw e;
        },
        //codeSent callback
        codeSent: (String verificationId, int? resendToken) async {
          print("$TAG codeSent");
          print("$TAG verificationId : $verificationId");
          print("$TAG resendToken : $resendToken");

          // wait for the result that sent form PromptVerifyCode and store
          // it to smsCode to open new session with phone credential
          await Future.delayed(Duration(seconds: 1));
          final smsCode = await onCodeSent;

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          userCredential = await _auth.signInWithCredential(phoneAuthCredential).catchError((error) {
            onVerificationFailed(error);
          });

          //since signInWithPhone triggered in both login and sign up
          //check if the user exist get their data otherwise create new user
          // final _user = await _getTUserOrCreateIfNotExist();

          // await _addCurrentDeviceToken(); // add the current device token to the user tokens list

          print("$TAG logged in as  $number !");
          //return either the exist user or the new created one
          onPhoneVerified(userCredential, number);
          // return userCredential;
        },
        //codeAutoRetrievalTimeout callback
        codeAutoRetrievalTimeout: (String verificationId) {
          print("$TAG codeAutoRetrievalTimeout");
          print("$TAG verificationId : $verificationId");
        },
      );
      return userCredential;
    } catch (e) {
      print('$TAG $e');
      onVerificationFailed(Exception(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      print('$TAG logging out..');
      await _auth.signOut();
      print('$TAG signed out successfully');
    } catch (e) {
      print('$TAG $e');
    }
  }

  @override
  resetPassword() {
    throw UnimplementedError();
  }
}
