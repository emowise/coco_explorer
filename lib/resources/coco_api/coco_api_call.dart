import 'dart:convert';

import 'package:http/http.dart' as http;

class CocoApiCall {
  static const _headers = {
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36",
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };

  static Future<Map<String, dynamic>> callResponseMap(Map body) async {
    final response = await _httpResponse(body);

    return (json.decode(response.body)).asMap().cast<String, dynamic>();
  }

  static Future<http.Response> _httpResponse(Map body) {
    return http.post(
        Uri.parse(
            "https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery"),
        headers: _headers,
        body: json.encode(body));
  }

}
