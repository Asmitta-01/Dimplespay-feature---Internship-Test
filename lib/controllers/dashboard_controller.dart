import 'package:dimplespay_feature_implementation/models/transaction.dart';
import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:dimplespay_feature_implementation/widgets/top_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  List<Transaction> transactions = [];
  double? balance = 0.0;

  final ApiService _apiService = Get.find<ApiService>();

  DashboardController() {
    _loadBalance();
    _fetchTransactions();
  }

  void _loadBalance() {
    _apiService.getWalletBalance().then((value) {
      balance = value;
      update();
    }).catchError((e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
        backgroundColor: Get.theme.colorScheme.error,
        icon: const Icon(Icons.money_off_csred_outlined),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      ));

      // balance = 0.00;
      // update();
    });
  }

  void _fetchTransactions() {
    transactions = [
      Transaction(
        id: 1,
        amount: 15000,
        type: 'payment',
        description: "Payment in shop",
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Transaction(
        id: 2,
        amount: 7550,
        type: 'transfer',
        description: "Transfer to Jane Doe",
        status: 'pending',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Transaction(
        id: 3,
        amount: 1500,
        type: 'topup',
        description: "Top up wallet",
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(hours: 7)),
      ),
      Transaction(
        id: 4,
        amount: 29999,
        type: 'payment',
        description: "Payment in shop",
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      Transaction(
        id: 5,
        amount: 4500,
        type: 'refund',
        description: "Refund from shop",
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      ),
      Transaction(
        id: 6,
        amount: 19999,
        type: 'payment',
        description: "Payment in gaz station",
        status: 'failed',
        timestamp: DateTime.now().subtract(const Duration(hours: 24)),
      ),
      Transaction(
        id: 7,
        amount: 10500,
        type: 'payment',
        description: "Payment in shop",
        status: 'completed',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  void topUp() {
    Get.bottomSheet(
      const TopUpWidget(),
      enableDrag: false,
      isDismissible: true,
      isScrollControlled: true,
    ).then((result) {
      if (result == true) {
        _loadBalance();
      }
    });
  }

  void transfer() {}

  void goToTransactionsScreen() {}
}
