class Transaction {
  final String id;
  final double amount;
  final String type;
  final String status;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.status,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'].toDouble(),
      type: json['type'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
