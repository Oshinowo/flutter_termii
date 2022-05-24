import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  static late http.Response response;

  static Future<dynamic> getRequest(
      {required String url, Map<String, String>? headers}) async {
    response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
    }
  }

  static Future<dynamic> postRequest(
      {required String url,
      Map<String, String>? headers,
      required Object body}) async {
    response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    return response;
  }
}
