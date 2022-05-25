import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConfig {
  // uncommnet the required prefered currency
  // static const PREFFERED_QURRENCY_UNIT = "\$";
  // static const PREFFERED_QURRENCY_UNIT = "Є";
  // static const PREFFERED_QURRENCY_UNIT = "£";
  // static const PREFFERED_QURRENCY_UNIT = "¥";
  static const PREFFERED_QURRENCY_UNIT = "IQD ";

  static const FREE_SHIPPING_MIN_TOTAL = 300000;

  static const CONTACT_PHONE = "07832005005"; // used to make phone call and via whatsapp

  static const CONTACT_PHONE_FORMATTED = "07832005005";
  static const CONTACT_PHONE_FORMATTED2 = "07732005005";
  static const URL_FAQs = "https://fayaclinica.com/faq/";
  static const URL_PRIVACY_POLICY = "https://fayaclinica.com/usage-policy/";
  static const URL_TERMS_CONDITIONS = "https://fayaclinica.com/refund-return/";
  static const MAP_LATLNG = LatLng(30.5079574, 47.8362379);

  // can be configured
  static const bool _HTTPS = true; // whether to make requests over SSL or not
  static const DOMAIN_PATH = "api.fayaclinica.com"; // main domain path

  //do not configure these below
  static const String API_ENDPATH = "api/";
  static const String SCHEME = _HTTPS ? "https" : "http";
  static const String _PROTOCOL = _HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "$_PROTOCOL$DOMAIN_PATH"; //https://api.fayaclinica.com
  static const String BASE_URL = "$RAW_BASE_URL/$API_ENDPATH"; //https://api.fayaclinica.com/api/
}
