import 'package:dimplespay_feature_implementation/controllers/dashboard_controller.dart';
import 'package:dimplespay_feature_implementation/controllers/login_controller.dart';
import 'package:dimplespay_feature_implementation/views/dashboard_screen.dart';
import 'package:dimplespay_feature_implementation/views/login_screen.dart';
import 'package:get/get.dart';

abstract class Routes {
  Routes._();

  static const login = '/login';

  static const dashboard = '/dashboard';
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
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
      binding: BindingsBuilder.put(() => DashboardController()),
    ),
  ];
}
