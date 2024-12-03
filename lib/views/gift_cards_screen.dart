import 'package:dimplespay_feature_implementation/controllers/gift_cards_controller.dart';
import 'package:dimplespay_feature_implementation/widgets/gift_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GiftCardsScreen extends GetView<GiftCardsController> {
  const GiftCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftCardsController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Gift Cards')),
          body: controller.isLoading
              ? Center(
                  child: LoadingAnimationWidget.beat(
                    color: Get.theme.colorScheme.primary,
                    size: 90,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: controller.loadGiftCards,
                  backgroundColor: Get.theme.colorScheme.surface,
                  child: ListView.builder(
                    itemCount: controller.giftCards.length,
                    itemBuilder: (context, index) {
                      final card = controller.giftCards[index];
                      return GiftCardWidget(
                        giftCard: card,
                        onPurchase: () => controller.purchaseGiftCard(card),
                      );
                    },
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed:
                controller.redeeming ? null : controller.showRedeemDialog,
            backgroundColor: Get.theme.colorScheme.primary,
            child: controller.redeeming
                ? LoadingAnimationWidget.beat(
                    color: Get.theme.colorScheme.onPrimary, size: 20)
                : const Icon(Icons.redeem),
          ),
        );
      },
    );
  }
}
