import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService extends http.BaseClient {
  final _httpClient = http.Client();
  final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
  };

  void addHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _httpClient.send(request);
  }
}

final httpService = HttpService();
