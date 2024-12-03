// gift_cards_controller.dart
import 'package:dimplespay_feature_implementation/models/gift_card.dart';
import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiftCardsController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  List<GiftCard> giftCards = <GiftCard>[];
  bool isLoading = true;

  GiftCardsController() {
    loadGiftCards();
  }

  Future<void> loadGiftCards() async {
    try {
      isLoading = true;
      giftCards = await _apiService.getAvailableGiftCards();
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
        backgroundColor: Get.theme.colorScheme.error,
        icon: Icon(
          Icons.wallet_giftcard,
          color: Get.theme.colorScheme.onError,
        ),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      ));
    } finally {
      isLoading = false;
    }
    update();
  }

  Future<void> purchaseGiftCard(GiftCard card) async {
    try {
      final success = await _apiService.purchaseGiftCard(card.id);
      if (success) {
        Get.showSnackbar(GetSnackBar(
          message: 'Gift card purchased successfully',
          duration: const Duration(seconds: 3),
          backgroundColor: Get.theme.colorScheme.error,
          icon: const Icon(Icons.wallet_giftcard, color: Colors.green),
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        ));
        loadGiftCards();
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
        backgroundColor: Get.theme.colorScheme.error,
        icon: Icon(
          Icons.payment,
          color: Get.theme.colorScheme.onError,
        ),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      ));
    }
  }

  Future<void> redeemGiftCard(String code) async {}

  void showRedeemDialog() {
    final codeController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Redeem Gift Card'),
        content: TextField(
          controller: codeController,
          decoration: const InputDecoration(
            labelText: 'Enter Gift Card Code',
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => redeemGiftCard(codeController.text),
            child: const Text('Redeem'),
          ),
        ],
      ),
    );
  }
}
