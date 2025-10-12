import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../features/login/views/login_view.dart';
import '../../features/login/views/register_view.dart';

/// 中央路由定義：避免以字串導頁
enum AppRoute {
  login('/login'),
  register('/register'),
  home('/home');

  const AppRoute(this.path);
  final String path;
}

class AppRouter {
  AppRouter._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: AppRoute.login.path, page: () => const LoginView()),
    GetPage(name: AppRoute.register.path, page: () => const RegisterView()),
    GetPage(
      name: AppRoute.home.path,
      page: () => const Placeholder(), // TODO: replace with real HomeView
    ),
  ];

  static Future<T?> to<T>(AppRoute route, {dynamic arguments, int? id}) async {
    return Get.toNamed<T>(route.path, arguments: arguments, id: id);
  }

  static Future<T?> offAll<T>(AppRoute route, {dynamic arguments, int? id}) async {
    return Get.offAllNamed<T>(route.path, arguments: arguments, id: id);
  }

  static Future<T?> off<T>(AppRoute route, {dynamic arguments, int? id}) async {
    return Get.offNamed<T>(route.path, arguments: arguments, id: id);
  }

  static void back<T extends Object?>([T? result]) {
    Get.back<T>(result: result);
  }
}


