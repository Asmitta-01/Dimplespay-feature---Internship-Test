import 'package:dimplespay_feature_implementation/models/gift_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiftCardWidget extends StatelessWidget {
  final GiftCard giftCard;
  final VoidCallback onPurchase;

  const GiftCardWidget(
      {super.key, required this.giftCard, required this.onPurchase});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CFA ${giftCard.amount}',
              style: Get.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Card Code: ${giftCard.code}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: giftCard.isRedeemed ? null : onPurchase,
              child: Text(
                giftCard.isRedeemed ? 'Redeemed' : 'Purchase',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
