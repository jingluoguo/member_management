import 'package:get/get.dart';
import 'package:member_management/modules/detail_module/detail_binding.dart';
import 'package:member_management/modules/detail_module/detail_page.dart';
import 'package:member_management/modules/main_modoule/main_binding.dart';
import 'package:member_management/modules/main_modoule/main_page.dart';

import '../modules/splash_module/splash_page.dart';
import '../modules/splash_module/splash_bindings.dart';

part './app_routes.dart';

abstract class AppPages {
  static const INITIAL = Routes.splash;
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: ()=> const MainPage(),
      binding: MainBinding()
    ),
    GetPage(
        name: Routes.detail,
        page: ()=> const DetailPage(),
        binding: DetailBinding()
    ),
  ];
}
