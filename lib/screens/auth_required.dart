import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/auth/sign_in/sign_in_screen.dart';
import 'package:faya_clinic/screens/auth/sign_up/signup_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRequiredScreen extends StatelessWidget {
  final String? message;
  const AuthRequiredScreen({Key? key, this.message}) : super(key: key);

  static Future show(BuildContext context, [String? message]) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AuthRequiredScreen(message: message)));
  }

  handleButtonClick(BuildContext context, AuthController controller) {
    late Widget child;
    if (controller.authState!.value == AuthState.LOGGED_OUT.value) {
      child = SignInScreen();
    }
    if (controller.authState!.value == AuthState.PHONE_VERIFIED.value) {
      child = SignUpScreen(controller: controller);
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => child));
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Scaffold(
      body: buildBody(context, controller),
    );
  }

  Widget buildBody(BuildContext context, AuthController controller) {
    print("buildBody ${controller.authState!.value}");
    var msg = "";
    var btn = "";
    if (controller.authState!.value == AuthState.LOGGED_OUT.value) {
      msg = message ?? TransUtil.trans("msg_auth_required");
      btn = TransUtil.trans("btn_sign_in");
    }
    if (controller.authState!.value == AuthState.PHONE_VERIFIED.value) {
      msg = TransUtil.trans("msg_one_step_complete_profile");
      btn = TransUtil.trans("btn_complete_profile");
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(marginLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(msg, textAlign: TextAlign.center),
          SizedBox(height: marginLarge),
          StandardButton(
            radius: radiusStandard,
            text: btn,
            onTap: () => handleButtonClick(context, controller),
          ),
        ],
      ),
    );
  }
}
