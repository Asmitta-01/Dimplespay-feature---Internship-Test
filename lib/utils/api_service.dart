import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dimplespay_feature_implementation/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://192.168.1.121:8000";

  String? _authToken;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: _headers,
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 8));
      ;

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
    } on TimeoutException {
      return "Request timeout, check your connection";
    } on SocketException {
      return "Please check your internet connection";
    } catch (e) {
      if (kDebugMode) print('Login error: $e');
      return 'Login error';
    }
  }

  Future<double> getWalletBalance() async {
    if (_authToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wallet/balance'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['balance'].toDouble();
      } else {
        throw Exception('Failed to fetch balance: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Balance fetch error: $e');
    }
  }

  Future<List<Transaction>> getTransactions(
      {int page = 1, int limit = 10}) async {
    if (_authToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wallet/transactions?page=$page&limit=$limit'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['transactions'] as List)
            .map((transaction) => Transaction.fromJson(transaction))
            .toList();
      } else {
        throw Exception('Failed to fetch transactions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Transactions fetch error: $e');
    }
  }

  void logout() {
    _authToken = null;
  }
}
