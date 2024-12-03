class GiftCard {
  final String id;
  final double amount;
  final String code;
  final bool isRedeemed;

  GiftCard({
    required this.id,
    required this.amount,
    required this.code,
    this.isRedeemed = false,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      id: json['id'],
      amount: json['amount'].toDouble(),
      code: json['code'],
      isRedeemed: json['isRedeemed'] ?? false,
    );
  }
}
