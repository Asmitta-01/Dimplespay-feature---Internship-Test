import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TopUpWidget extends StatefulWidget {
  const TopUpWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return TopUpWidgetState();
  }
}

class TopUpWidgetState extends State<TopUpWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  final ApiService _apiService = Get.find<ApiService>();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();

  bool makingTopUp = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Up",
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
                "Enter the amount you want to top-up in your wallet. It should be greater than 0."),
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
                      hintText: "100000, 5000, ...",
                      prefixText: 'CFA  ',
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: makingTopUp ? () {} : sendRequest,
                  child: makingTopUp
                      ? LoadingAnimationWidget.beat(
                          color: Get.theme.colorScheme.onPrimary, size: 20)
                      : const Text("Proceed"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sendRequest() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    setState(() {
      makingTopUp = true;
    });

    String errorText = 'An error occurs';
    bool topupWallet = await _apiService
        .topupWallet(double.tryParse(_textEditingController.text) ?? 0.0)
        .catchError((e) {
      errorText = e.toString();
      return false;
    });
    if (topupWallet) {
      Get.back(result: true);
      Get.showSnackbar(GetSnackBar(
        message: 'Wallet funded',
        duration: const Duration(seconds: 2),
        backgroundColor: Get.theme.colorScheme.primary,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Get.theme.colorScheme.onPrimary,
        ),
      ));
      setState(() {
        makingTopUp = false;
      });
    } else {
      Get.showSnackbar(GetSnackBar(
        message: errorText,
        duration: const Duration(seconds: 2),
        backgroundColor: Get.theme.colorScheme.error,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: const Icon(Icons.credit_card_off),
      ));
    }
  }
}
