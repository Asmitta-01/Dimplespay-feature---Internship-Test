class NfcCard {
  final int id;
  final String serialNumber;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int balance;
  final String activationDate;
  final int cardNumber;
  final int pinCode;

  NfcCard({
    required this.id,
    required this.serialNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.balance,
    required this.activationDate,
    required this.cardNumber,
    required this.pinCode,
  });

  factory NfcCard.fromJson(Map<String, dynamic> json) {
    return NfcCard(
      id: json['id'] as int,
      serialNumber: json['serialNumber'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      balance: json['balance'] as int,
      activationDate: json['activationDate'] as String,
      cardNumber: json['cardNumber'] as int,
      pinCode: json['pinCode'] as int,
    );
  }
}
