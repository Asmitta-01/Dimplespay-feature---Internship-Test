class Transaction {
  final int id;
  final double amount;
  final String type;
  final String status;
  final String description;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.status,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'].toDouble(),
      type: json['type'],
      description: json['description'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
