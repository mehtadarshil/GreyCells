import 'dart:convert';

import 'package:greycell_app/src/config/apiauth_config.dart';
import 'package:http/http.dart' as http;
import 'package:greycell_app/src/commons/widgets/query_params.dart';

class DataFilter {
  Future<Map<String, dynamic>?> getToken(
      {String? serverUrl, String? apiCode}) async {
    Map<String, dynamic>? _content;

    try {
      final URLQueryParams queryParams = new URLQueryParams();
      queryParams.append("response_type", "token");
      queryParams.append("client_secret", "test_secret");
      queryParams.append("grant_type", "authorization_code");
      queryParams.append("client_id", ApiAuth.KSPLID);
      queryParams.append("API_CODE", apiCode);
//      print(queryParams);
      String url = "$serverUrl?$queryParams";
      print("Token URL: \n");
      print(url);
      http.Response _response =
          await http.get(Uri.parse(url), headers: getHeaders());
      print(_response.body);
      if (_response.statusCode == 200) {
        final content = json.decode(_response.body);
        if (content['accessToken'] != null) {
          print("Token Map: $content");
          _content = content;
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
    return _content;
  }

  // Get headers Map
  Map<String, String> getHeaders() {
    return {"Content-Type": "application/json"};
  }

  Future<String> toJsonResponse({required String callback, required String response}) async {
    // Response filterations
    // Gettting CallBack Length ex: callback = clientList() --- here length of callback + 1 to remove '(' as well.
    // response.length - 2 := removing two elements from right side ex: -clientList({"isSuccess":true});
    int callBackCodeLength = callback.length + 1;
    return await response.substring(callBackCodeLength, response.length - 2);
  }
}
