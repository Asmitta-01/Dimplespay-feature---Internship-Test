import 'package:dimplespay_feature_implementation/controllers/login_controller.dart';
import 'package:dimplespay_feature_implementation/views/login_screen.dart';
import 'package:get/get.dart';

abstract class Routes {
  Routes._();

  static const login = '/login';
}

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
  ];
}
