import 'package:dimplespay_feature_implementation/models/transaction.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  List<Transaction> transactions = [];

  DashboardController() {
    _fetchTransactions();
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
        description: "Top up card",
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

  void topUp() {}

  void transfer() {}

  void goToTransactionsScreen() {}
}
