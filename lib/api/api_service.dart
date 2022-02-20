import 'dart:convert';

import 'package:faya_clinic/api/api.dart';
import 'package:faya_clinic/models/response/post_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print('Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<List<T>> getData<T>({
    // @required String accessToken,
    @required T Function(dynamic data) builder,
    @required String path,
  }) async {
    // final uri = api.endpointUri(endpoint, parameters);
    final uri = api.endpointUri(path);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body);
      final data = items.map((e) => builder(e)).toList();
      print("getData: data ${data.toString()}");
      return data;
    }
    print('getData: Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<T> getObject<T>({
    // @required String accessToken,
    @required T Function(dynamic data) builder,
    @required String path,
  }) async {
    final uri = api.endpointUri(path);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic item = json.decode(response.body);
      final data = builder(item);
      print("getObject: data ${data.toString()}");
      return data;
    }
    print('getObject: Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<PostResponse> postData<T>({
    Map<String, dynamic> body,
    @required String path,
  }) async {
    final uri = api.endpointUri(path);

    String encodedBody = json.encode(body);
    final response = await http.post(uri, headers: {"Content-Type": "application/json"}, body: encodedBody);
    final postResponse = PostResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print('postData: Request $uri success\nResponse: 200');
    } else
      print('postData: Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    return postResponse;
  }
}
