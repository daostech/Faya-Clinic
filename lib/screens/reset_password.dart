import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height - paddingTop;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              // top left vector image
              bottom: screenHeight * 0.4,
              right: 0,
              width: screenWidth,
              height: screenHeight * 0.7,
              child: SvgPicture.asset(
                IMG_AUTH_TOP_LEFT,
                fit: BoxFit.none,
              ),
            ),
            Positioned(
              // top right vector image
              bottom: screenHeight * 0.6,
              left: screenWidth * 0.5,
              width: screenWidth * 0.6,
              height: screenHeight * 0.5,
              child: SvgPicture.asset(IMG_AUTH_TOP_RIGHT),
            ),
            Positioned(
              // bottom right vector image
              top: screenHeight * 0.4,
              // left: 0,
              // right: 0,
              width: screenWidth + screenWidth * 0.5,
              height: screenHeight * 0.9,
              child: SvgPicture.asset(
                IMG_AUTH_BOTTOM_RIGHT,
                fit: BoxFit.none,
              ),
            ),
            Positioned(
              // bottom left vector image
              top: screenHeight * 0.65,
              right: screenWidth * 0.7,
              width: screenWidth * 0.5,
              height: screenHeight * 0.5,
              child: SvgPicture.asset(
                IMG_AUTH_BOTTOM_LEFT,
                fit: BoxFit.none,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(marginLarge * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Password confirmation",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeLarge,
                      ),
                    ),
                    SizedBox(
                      height: marginLarge,
                    ),
                    RadiusBorderedInput(
                      hintText: TransUtil.trans("hint_enter_your_phone"),
                    ),
                    InlineButtons(
                      positiveText: TransUtil.trans("btn_sign_in"),
                      negativeText: TransUtil.trans("btn_cancel"),
                      onPositiveTap: () {},
                      onNegativeTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
