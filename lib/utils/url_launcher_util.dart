import 'dart:io';

import 'package:faya_clinic/constants/config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  // static c onst _CLINIC_PHONE_NUMBER = AppConfig.CONTACT_PHONE;
  static const _CLINIC_PHONE_NUMBER = AppConfig.CONTACT_PHONE_FORMATTED2;
  static const _WHATSAPP_DEF_MESSAGE = "Hi, I have a question\n\n";
  static const _WHATSAPP = "https://wa.me/$_CLINIC_PHONE_NUMBER?text=$_WHATSAPP_DEF_MESSAGE";
  static const _CALL = "tel://$_CLINIC_PHONE_NUMBER";
  static const _CALL_2 = "tel://";

  Future openWhatsApp() {
    final encoded = Uri.encodeFull(_WHATSAPP);
    return _launchUniversalLink(encoded);
  }

  Future openDialNumber() async {
    if (await canLaunch(_CALL)) {
      await launch(_CALL);
    } else {
      throw 'error_cant_open_dial_numpad';
    }
  }

  static Future openDialNumberFor(String number) async {
    final numUri = _CALL_2 + number;
    if (await canLaunch(numUri)) {
      await launch(numUri);
    } else {
      throw 'error_cant_open_dial_numpad';
    }
  }

  static void openURL(String url) {
    final encoded = Uri.encodeFull(url);
    _launchUniversalLink(encoded);
  }

  static void openMap(LatLng latLng) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'error_cant_open_map';
    }
  }

  static Future<void> _launchUniversalLink(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );

      Future<void> _launchInWebViewOrVC(String url) async {
        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: true,
            forceWebView: true,
            // headers: <String, String>{'my_header_key': 'my_header_value'},
          );
        } else {
          throw 'Could not launch $url';
        }
      }

      Future<void> _launchInWebViewWithJavaScript(String url) async {
        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: true,
            forceWebView: true,
            enableJavaScript: true,
          );
        } else {
          throw 'Could not launch $url';
        }
      }

      ///if the link could not be handled in the native app
      if (!nativeAppLaunchSucceeded) {
        ///if ios open the link in safari browser or web view
        if (Platform.isIOS) {
          await _launchInWebViewOrVC(url);
        }

        ///if Android open the link in browser or web view
        if (Platform.isAndroid) {
          await _launchInWebViewWithJavaScript(url);
        }
      }
    }
  }
}
