import 'package:faya_clinic/api/api_keys.dart';

class API {
  API({this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.key);

  static final String host = 'sys.fayaclinica.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );

  Uri endpointUri(String path) => Uri(
        scheme: 'https',
        host: host,
        path: path,
      );
}
