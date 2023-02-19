import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/auth/sign_in/sign_in_screen.dart';
import 'package:faya_clinic/screens/auth/sign_up/signup_screen.dart';
import 'package:faya_clinic/screens/intro_sliders.dart';
import 'package:faya_clinic/screens/loading_screen.dart';
import 'package:faya_clinic/screens/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    print("AuthWrapper: _authState:${controller.authState!.value}");
    print("AuthWrapper: _myUser:${controller.myUser?.toJson()}");

    return Builder(
      builder: (ctx) {
        print("first open ${controller.firstOpen}");
        if (controller.isLoading) {
          return LoadingScreen();
        }
        if (controller.firstOpen!) {
          return IntroScreen(controller: controller);
        }
        // if (controller.authState.value == AuthState.LOGGED_IN.value) {
        //   return HomeMainWrapper();
        // }
        if (controller.authState!.value == AuthState.PHONE_VERIFIED.value) {
          return SignUpScreen(controller: controller);
        }
        //  else
        // return SignInScreen();
        return HomeMainWrapper();
      },
    );
  }
}
