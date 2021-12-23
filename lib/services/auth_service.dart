import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jei_project_manager_app/config.dart';
import 'package:jei_project_manager_app/services/http_service.dart';

class AuthService {
  var isAdmin = false;
  String? _token;
  final _storage = const FlutterSecureStorage();

  bool get isLoggedIn {
    return _token != null;
  }

  Future<bool> init() async {
    Map<String, String> values = await _storage.readAll();
    if (values.containsKey("auth_token") && values["auth_token"]!.isNotEmpty) {
      _token = values["auth_token"];
    }
    if (values.containsKey("is_admin") && values["is_admin"] == "true") {
      isAdmin = true;
    }
    httpService.addHeaders({HttpHeaders.authorizationHeader: 'Bearer $_token'});
    return true;
  }

  Future<void> login(String username, String password) async {
    final response = await httpService.post(
      Uri.parse(Config.apiURL + "/auth/login"),
      body: json.encode({'username': username, 'password': password}),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 400) {
      _token = data["token"];
      isAdmin = data.containsKey("isAdmin") ? data["isAdmin"] : false;
      _storage.write(key: "auth_token", value: _token).catchError((e) {});
      _storage
          .write(key: "is_admin", value: isAdmin ? "true" : "false")
          .catchError((e) {});
    } else {
      throw Exception(data["message"]);
    }
  }

  Future<void> signup(String email, String username, String password) async {
    final response = await httpService.post(
      Uri.parse(Config.apiURL + "/auth/signup"),
      body: json
          .encode({'email': email, 'username': username, 'password': password}),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 400) {
      _token = data["token"];
      isAdmin = data.containsKey("isAdmin") ? data["isAdmin"] : false;
      _storage.write(key: "auth_token", value: _token).catchError((e) {});
      _storage
          .write(key: "is_admin", value: isAdmin ? "true" : "false")
          .catchError((e) {});
    } else {
      throw Exception(data["message"]);
    }
  }
}

final authService = AuthService();
