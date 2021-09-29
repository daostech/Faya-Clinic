import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/input_standard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      StandardInput(
                        margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                        hintText: TransUtil.trans("hint_your_phone"),
                        onChanged: (val) {},
                      ),
                      StandardInput(
                        margin: const EdgeInsets.symmetric(horizontal: marginLarge, vertical: marginStandard),
                        hintText: TransUtil.trans("hint_your_password"),
                        onChanged: (val) {},
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: marginLarge),
                          child: Text(TransUtil.trans("hint_forgot_password")),
                        ),
                      ),
                      SizedBox(
                        height: marginLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: colorGrey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radiusStandard),
                                      bottomLeft: Radius.circular(radiusStandard),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(marginStandard),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        TransUtil.trans("btn_cancel").toUpperCase(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: marginStandard,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                radius: radiusStandard,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(radiusStandard),
                                      bottomRight: Radius.circular(radiusStandard),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(marginStandard),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        TransUtil.trans("btn_sign_in").toUpperCase(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: TransUtil.trans("hint_no_account_action"),
                              style: TextStyle(
                                color: primaryColor,
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
          ],
        ),
      ),
    );
  }
}
