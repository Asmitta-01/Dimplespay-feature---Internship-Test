import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://192.168.1.52:8000";

  String? _authToken;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final Map data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _authToken = data['token'];
        return null;
      } else if (data.containsKey('message') && data['message'] != null) {
        return data['message'];
      } else {
        return 'Login failed: ${response.reasonPhrase}';
      }
    } on FormatException {
      return "Unable to parse request response";
    } on SocketException {
      return "Please check your internet connection";
    } catch (e) {
      if (kDebugMode) print('Login error: $e');
      return 'Login error';
    }
  }

  void logout() {
    _authToken = null;
  }
}
