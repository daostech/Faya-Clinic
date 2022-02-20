import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/auth_controller.dart';
import 'package:faya_clinic/screens/auth/verify_code.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/input_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  Future<String> onCodeSent(context) async {
    //open the verify sms code screen and get the result back to be sent to AuthService
    print("SignInScreen: called");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifySMSCode(),
      ),
    );
    print("SignInScreen: code sent $result");
    return result;
  }

  submitForm(BuildContext context, controller) async {
    if (_formKey.currentState.validate()) {
      try {
        await controller.verifyPhoneNumber(onCodeSent(context));
      } catch (error) {
        DialogUtil.showAlertDialog(context, error.toString(), () {});
      }
    }
  }

  handleError(context, controller) {
    DialogUtil.showAlertDialog(context, controller.error, null);
    controller.onErrorHandled();
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height - paddingTop;
    final screenWidth = MediaQuery.of(context).size.width - paddingTop;

    return Consumer<AuthController>(
      builder: (context, controller, _) {
        if (controller.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            print("addPostFrameCallback called");
            handleError(context, controller);
          });
        }
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
                  top: 75,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(marginLarge),
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
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
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizexLarge),
                          ),
                          SizedBox(
                            height: marginSmall,
                          ),
                          Text(
                            TransUtil.trans("sign_in_hint"),
                            style: TextStyle(fontSize: fontSizeLarge),
                          ),
                          SizedBox(
                            height: marginxLarge,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                PhoneNumberInput(
                                  margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                                  hintText: TransUtil.trans("hint_enter_your_phone"),
                                  onChanged: (val) => controller.inputPhoneNumber = val,
                                  onCountryCodeChanged: (value) => controller.inputCountryDialCode = value,
                                  isRequiredInput: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: marginxLarge,
                          ),
                          StandardButton(
                            radius: radiusStandard,
                            // text: TransUtil.trans("btn_sign_in"),
                            text: TransUtil.trans("btn_continue"),
                            onTap: controller.isLoading ? null : () => submitForm(context, controller),
                          ),
                          SizedBox(
                            height: marginLarge,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
