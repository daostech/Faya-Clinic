import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static const _CLINIC_PHONE_NUMBER = "+905366389928";
  static const _WHATSAPP_DEF_MESSAGE = "Hi how are you";
  static const _WHATSAPP = "https://wa.me/$_CLINIC_PHONE_NUMBER?text=$_WHATSAPP_DEF_MESSAGE";

  void openWhatsApp() {
    final encoded = Uri.encodeFull(_WHATSAPP);
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

  Future<void> _launchUniversalLink(String url) async {
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
