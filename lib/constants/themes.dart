import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: colorBg,
    primaryColor: colorPrimary,
    primaryColorLight: colorPrimaryLight,
    indicatorColor: colorPrimaryLight,
    splashColor: colorSplash,
    highlightColor: colorSplash,
    focusColor: colorSplash,
    fontFamily: "Tajawal",
    primaryTextTheme: TextTheme(
      headline1: TextStyle(color: Colors.black, fontSize: fontSizeLarge),
      bodyText1: TextStyle(color: Colors.black, fontSize: fontSizeStandard),
      bodyText2: TextStyle(color: Colors.black, fontSize: fontSizeSmall),
      subtitle1: TextStyle(color: colorGreyDark, fontSize: fontSizeStandard),
      subtitle2: TextStyle(color: colorGreyDark, fontSize: fontSizeSmall),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorPrimary,
    ),
    colorScheme: ColorScheme.light(
      primary: colorPrimary,
      secondary: colorPrimaryLight,
      onSecondary: colorPrimaryLight,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => colorSplash,
        ),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) => colorSplash,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => colorSplash,
        ),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) => colorSplash,
        ),
      ),
    ),
  );
}
