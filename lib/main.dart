import 'dart:io';

import 'package:dimplespay_feature_implementation/routes.dart';
import 'package:dimplespay_feature_implementation/utils/api_service.dart';
import 'package:dimplespay_feature_implementation/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  init();
  runApp(const MyApp());
}

void init() {
  HttpOverrides.global = MyHttpOverrides();

  ApiService apiService = ApiService();
  Get.lazyPut(() => apiService, fenix: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "DimplesPay",
      initialRoute: Routes.login,
      defaultTransition: Transition.rightToLeft,
      themeMode: ThemeMode.light,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
