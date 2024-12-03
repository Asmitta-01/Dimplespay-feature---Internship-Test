import 'package:dimplespay_feature_implementation/models/transaction.dart';
import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:dimplespay_feature_implementation/widgets/deduct_widget.dart';
import 'package:dimplespay_feature_implementation/widgets/top_up_widget.dart';
import 'package:dimplespay_feature_implementation/widgets/transfer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  List<Transaction> transactions = [];
  double? balance, cardBalance = 0.0;
  bool cardIsActive = false, activatingCard = false;

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
      _displaySnackbar(e.toString(), Icons.money_off_csred_outlined,
          isError: true);

      balance = 0.00;
      update();
    });
  }

  SnackbarController _displaySnackbar(String message, IconData iconData,
      {bool isError = false}) {
    return Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor:
          isError ? Get.theme.colorScheme.error : Get.theme.colorScheme.primary,
      icon: Icon(
        iconData,
        color: isError
            ? Get.theme.colorScheme.onError
            : Get.theme.colorScheme.onPrimary,
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    ));
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

  void transfer() {
    Get.bottomSheet(
      const TransferWidget(),
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
    ).then((result) {
      if (result == true) {
        _loadBalance();
      }
    });
  }

  void showCardActions() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Top up card"),
              onTap: () {
                Get.back();
                transfer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text("Deduct card"),
              onTap: () {
                Get.back();
                deductCard();
              },
            ),
          ],
        ),
      ),
      enableDrag: false,
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  void deductCard() {
    Get.bottomSheet(
      const DeductWidget(),
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
    ).then((result) {
      if (result == true) {
        _loadBalance();
      }
    });
  }

  void activateCard() async {
    activatingCard = true;
    update();

    cardIsActive = await _apiService.activateCard().catchError((e) {
      _displaySnackbar(
        e.toString(),
        Icons.pivot_table_chart_rounded,
        isError: true,
      );
      return false;
    });
    activatingCard = false;
    update();

    if (cardIsActive) {
      _displaySnackbar("Card activated", Icons.payment);
    }
  }

  void goToTransactionsScreen() {}
}
