import 'package:dimplespay_feature_implementation/routes.dart';
import 'package:dimplespay_feature_implementation/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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
