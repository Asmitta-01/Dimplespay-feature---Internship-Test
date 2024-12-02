// import 'package:dimplespay_feature_implementation/routes.dart';
import 'package:dimplespay_feature_implementation/routes.dart';
import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.find();

  Future<String?> login(String email, String password) async {
    String? result = await _apiService.login(email: email, password: password);
    if (result == null) {
      Get.offAllNamed(Routes.dashboard);
      Get.showSnackbar(GetSnackBar(
        message: 'Login successful',
        duration: const Duration(seconds: 2),
        backgroundColor: Get.theme.colorScheme.primary,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(
          Icons.check_circle_outline_outlined,
          color: Get.theme.colorScheme.onPrimary,
        ),
      ));
    }
    return result;
  }
}
