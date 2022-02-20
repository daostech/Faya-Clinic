import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  IMG_LOGO,
                  width: screenWidth * 0.35,
                ),
                SizedBox(
                  height: marginLarge,
                ),
                Text(
                  TransUtil.trans(
                    "app_name",
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeLarge,
                    color: colorPrimary,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
