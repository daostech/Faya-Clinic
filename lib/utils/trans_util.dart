import 'package:easy_localization/easy_localization.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class TransUtil {
  static String trans(String text) {
    return text.tr();
  }

  static String getCurrentLangCode(BuildContext context) {
    return EasyLocalization.of(context).locale.toString();
  }

  static Locale getCurrentLocale(BuildContext context) {
    return EasyLocalization.of(context).locale;
  }

  static void changeLocale(BuildContext context, String localeCode) {
    context.setLocale(Locale(localeCode));
  }

  static bool isArLocale(BuildContext context) {
    return EasyLocalization.of(context).locale == Locale(langArCode);
  }

  static bool isEnLocale(BuildContext context) {
    return EasyLocalization.of(context).locale == Locale(langEnCode);
  }
}
