import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    }
    return Future.error(response.statusCode);
  }

  Future<Map<String, dynamic>> getDataByCountry(
  ) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        return Future.error(
          "ُError in fetch Country Weather ${response.statusCode}",
        );
      }
    } catch (e) {
      return Future.error("Connection Error: $e");
    }
  }
}
