import 'package:faya_clinic/api/api_keys.dart';
import 'package:faya_clinic/constants/config.dart';

class API {
  API({this.apiKey});
  final String? apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.key);

  static final String host = AppConfig.DOMAIN_PATH;

  Uri tokenUri() => Uri(
        scheme: AppConfig.SCHEME,
        host: host,
        path: 'token',
      );

  Uri endpointUri(String path) => Uri(
        scheme: AppConfig.SCHEME,
        host: host,
        path: path,
      );
}
