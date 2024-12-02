import 'package:dimplespay_feature_implementation/controllers/login_controller.dart';
import 'package:dimplespay_feature_implementation/utils/image_data.dart';
import 'package:dimplespay_feature_implementation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageData.logo,
                  height: 40,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 26),
                Text("Login",
                    style: Get.textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                const Text("Transfer Money With DimplePay In A Second"),
                const SizedBox(height: 16),
                LoginForm(onSubmit: controller.login),
              ],
            ),
          ),
        );
      },
    );
  }
}
