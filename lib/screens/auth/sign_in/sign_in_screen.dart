import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/auth/sign_in/sign_in_controller.dart';
import 'package:faya_clinic/screens/auth/verify_code.dart';
import 'package:faya_clinic/screens/reset_password.dart';
import 'package:faya_clinic/screens/auth/sign_up/signup_screen.dart';
import 'package:faya_clinic/services/auth_service.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_border_radius.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen._({Key key, @required this.controller}) : super(key: key);
  final SignInController controller;
  final _formKey = GlobalKey<FormState>();

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final authService = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(database: database, authService: authService),
      builder: (ctx, child) {
        return Consumer<SignInController>(
          builder: (context, controller, _) => SignInScreen._(controller: controller),
        );
      },
    );
  }

  Future<String> onCodeSent(context) async {
    //open the verify sms code screen and get the result back to be sent to AuthService
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifySMSCode(
          controller: controller,
        ),
      ),
    );
    print("SignUpWithPhone: code sent $result");
    return result;
  }

  submitForm(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      try {
        await controller.signIn(onCodeSent(context));
      } catch (error) {
        DialogUtil.showAlertDialog(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height - paddingTop;
    final screenWidth = MediaQuery.of(context).size.width - paddingTop;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              // top right vector image
              bottom: screenHeight * 0.75,
              right: screenWidth * 0.78,
              width: screenWidth * 0.4,
              height: screenHeight * 0.3,
              child: SvgPicture.asset(IMG_AUTH_TOP_LEFT),
            ),
            Positioned(
              // top left vector image
              bottom: screenHeight * 0.7,
              left: screenWidth * 0.7,
              width: screenWidth * 0.5,
              height: screenHeight * 0.4,
              child: SvgPicture.asset(IMG_AUTH_TOP_RIGHT),
            ),
            Positioned(
              // bottom left vector image
              top: screenHeight * 0.78,
              right: screenWidth * 0.84,
              width: screenWidth * 0.4,
              height: screenHeight * 0.3,
              child: SvgPicture.asset(IMG_AUTH_BOTTOM_LEFT),
            ),
            Positioned(
              // bottom right vector image
              top: screenHeight * 0.72,
              left: screenWidth * 0.75,
              width: screenWidth * 0.5,
              height: screenHeight * 0.4,
              child: SvgPicture.asset(IMG_AUTH_BOTTOM_RIGHT),
            ),
            Positioned(
              // login form container
              top: 50,
              bottom: 50,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(marginLarge),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IMG_LOGO,
                        width: screenWidth * 0.35,
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Text(
                        TransUtil.trans("sign_in"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: marginSmall,
                      ),
                      Text(
                        TransUtil.trans("sign_in_hint"),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            RadiusBorderedInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_enter_your_phone"),
                              onChanged: (val) => controller.phoneNumber = val,
                              textInputType: TextInputType.number,
                              isRequiredInput: true,
                            ),
                            RadiusBorderedInput(
                              margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                              hintText: TransUtil.trans("hint_your_password"),
                              onChanged: (val) => controller.password = val,
                              isRequiredInput: true,
                              minLength: 8,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) => ResetPasswordScreen(),
                                      ),
                                    ),
                              text: TransUtil.trans("hint_forgot_password"),
                              style: TextStyle(
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
                                fontSize: fontSizexSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                        child: InlineButtons(
                          positiveText: TransUtil.trans("btn_sign_in"),
                          negativeText: TransUtil.trans("btn_cancel"),
                          onPositiveTap: () => submitForm(context),
                          onNegativeTap: () {},
                        ),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(TransUtil.trans("hint_no_account")),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) => SignUpScreen(),
                                      ),
                                    ),
                              text: TransUtil.trans("hint_no_account_action"),
                              style: TextStyle(
                                color: colorPrimary,
                                decoration: TextDecoration.underline,
                                fontSize: fontSizeSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Visibility(
                  visible: controller.isLoading,
                  // visible: true,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 70),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
