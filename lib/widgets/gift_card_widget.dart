import 'package:dimplespay_feature_implementation/models/gift_card.dart';
import 'package:flutter/material.dart';

class GiftCardWidget extends StatelessWidget {
  final GiftCard giftCard;
  final VoidCallback onPurchase;

  const GiftCardWidget(
      {super.key, required this.giftCard, required this.onPurchase});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('CFA ${giftCard.amount}'),
      leading: const Icon(Icons.card_giftcard),
      visualDensity: VisualDensity.compact,
      subtitle: Text('Card Code: ${giftCard.code}'),
      trailing: ElevatedButton(
        onPressed: giftCard.isRedeemed ? null : onPurchase,
        style: ElevatedButton.styleFrom(visualDensity: VisualDensity.compact),
        child: Text(giftCard.isRedeemed ? 'Redeemed' : 'Purchase'),
      ),
    );
  }
}
