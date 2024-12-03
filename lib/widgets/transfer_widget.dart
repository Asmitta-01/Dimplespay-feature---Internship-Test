import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransferWidget extends StatefulWidget {
  const TransferWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return TransferWidgetState();
  }
}

class TransferWidgetState extends State<TransferWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  final ApiService _apiService = Get.find<ApiService>();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();

  bool transferring = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transfer funds",
                  style: Get.textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
                "Enter the amount you want to transfer to your NFC card. It should be greater than your wallet current balance."),
            const SizedBox(height: 12),
            buildCardTile(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: _key,
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter a valid amount"
                        : null,
                    decoration: const InputDecoration(
                      prefixText: 'CFA  ',
                      labelText: "Amount to be transferred",
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: transferring ? () {} : sendRequest,
                  child: transferring
                      ? LoadingAnimationWidget.beat(
                          color: Get.theme.colorScheme.onPrimary, size: 20)
                      : const Text("Transfer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardTile() {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Get.theme.colorScheme.primary, width: 2),
        boxShadow: [
          BoxShadow(
              color: Get.theme.colorScheme.primaryContainer, blurRadius: 3)
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            Icons.contactless_rounded,
            color: Get.theme.colorScheme.onSurface,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NFC Card",
                  style: Get.textTheme.titleMedium?.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  "Funds will be transferred to this card",
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Radio(value: true, onChanged: (_) {}, groupValue: true)
        ],
      ),
    );
  }

  void sendRequest() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    setState(() {
      transferring = true;
    });

    String errorText = 'An error occurs';
    bool topupCard = await _apiService
        .topupCard(double.tryParse(_textEditingController.text) ?? 0.0)
        .catchError((e) {
      errorText = e.toString();
      return false;
    });

    setState(() {
      transferring = false;
    });

    if (topupCard) {
      Get.back(result: true);
      Get.showSnackbar(GetSnackBar(
        message: 'Card funded',
        duration: const Duration(seconds: 2),
        backgroundColor: Get.theme.colorScheme.primary,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Get.theme.colorScheme.onPrimary,
        ),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        message: errorText,
        duration: const Duration(seconds: 2),
        backgroundColor: Get.theme.colorScheme.error,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: const Icon(Icons.money_off),
      ));
    }
  }
}
