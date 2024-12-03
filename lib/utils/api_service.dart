import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dimplespay_feature_implementation/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://192.168.150.166:8000";

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
      final response = await http
          .get(
            Uri.parse('$baseUrl/api/wallet/balance'),
            headers: _headers,
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['balance'].toDouble();
      } else {
        throw Exception('Failed to fetch balance: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception("Request timeout, check your connection");
    } on SocketException {
      throw Exception("Please check your internet connection");
    } catch (e) {
      throw Exception('An error occurs while fetching the balance');
    }
  }

  Future<bool> topupWallet(double amount) async {
    if (_authToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/wallet/topup'),
            headers: _headers,
            body: jsonEncode({
              'amount': amount,
            }),
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'];
      } else {
        throw Exception('Failed to topup your wallet: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception("Request timeout, check your connection");
    } on SocketException {
      throw Exception("Please check your internet connection");
    } catch (e) {
      throw Exception('An error occurs during the topup');
    }
  }

  Future<bool> activateCard() async {
    if (_authToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/nfc/activate'),
            headers: _headers,
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        return true;
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data['message']);
      }
    } on TimeoutException {
      throw Exception("Request timeout, check your connection");
    } on SocketException {
      throw Exception("Please check your internet connection");
    } catch (e) {
      throw Exception('An error occurs during the topup');
    }
  }

  Future<bool> topupCard(double amount) async {
    if (_authToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/nfc/topup'),
            headers: _headers,
            body: jsonEncode({
              'amount': amount,
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == false) {
          throw Exception(data['message']);
        }
        return true;
      } else {
        throw Exception('Failed to topup your wallet');
      }
    } on TimeoutException {
      throw Exception("Request timeout, check your connection");
    } on SocketException {
      throw Exception("Please check your internet connection");
    } catch (e) {
      throw Exception('An error occurs during the topup');
    }
  }

  Future<bool> deductCard(double amount, int pinCode) async {
    if (_authToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/nfc/deduct'),
            headers: _headers,
            body: jsonEncode({'amount': amount, 'pinCode': pinCode}),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == false) {
          throw Exception(data['message']);
        }
        return true;
      } else {
        throw Exception('Failed to deduct');
      }
    } on TimeoutException {
      throw Exception("Request timeout, check your connection");
    } on SocketException {
      throw Exception("Please check your internet connection");
    } catch (e) {
      throw Exception('An error occurs during the deduction');
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
