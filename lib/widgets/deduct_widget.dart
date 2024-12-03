import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DeductWidget extends StatefulWidget {
  const DeductWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return DeductWidgetState();
  }
}

class DeductWidgetState extends State<DeductWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  final ApiService _apiService = Get.find<ApiService>();

  final GlobalKey<FormFieldState> _amountKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _otpKey = GlobalKey<FormFieldState>();

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
                  "Deduct funds",
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
                "Enter the amount you want to deduct from your NFC card. It should be greater than your card current balance."),
            const SizedBox(height: 12),
            TextFormField(
              key: _amountKey,
              controller: _amountController,
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty
                  ? "Enter a valid amount"
                  : null,
              decoration: const InputDecoration(
                prefixText: 'CFA  ',
                labelText: "Amount to be deducted",
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              key: _otpKey,
              controller: _pinCodeController,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter your pin code" : null,
              decoration: const InputDecoration(labelText: "Pin code"),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: transferring ? () {} : sendRequest,
                    child: transferring
                        ? LoadingAnimationWidget.beat(
                            color: Get.theme.colorScheme.onPrimary, size: 20)
                        : const Text("Deduct"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sendRequest() async {
    if (!_amountKey.currentState!.validate() ||
        !_otpKey.currentState!.validate()) {
      return;
    }

    setState(() {
      transferring = true;
    });

    String errorText = 'An error occurs';
    bool deducted = await _apiService
        .deductCard(
      double.tryParse(_amountController.text) ?? 0.0,
      int.tryParse(_pinCodeController.text) ?? 1,
    )
        .catchError((e) {
      errorText = e.toString();
      return false;
    });

    setState(() {
      transferring = false;
    });

    if (deducted) {
      Get.back(result: true);
      Get.showSnackbar(GetSnackBar(
        message: 'Funds deducted',
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
        icon: const Icon(Icons.credit_card_off),
      ));
    }
  }
}
