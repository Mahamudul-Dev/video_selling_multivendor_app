import 'package:get/get.dart';

import '../buyer/module/buyer_dashboard/bindings/buyer_dashboard_binding.dart';
import '../buyer/module/buyer_dashboard/views/buyer_dashboard_view.dart';
import '../buyer/module/buyer_cart/bindings/buyer_cart_binding.dart';
import '../buyer/module/buyer_cart/views/buyer_cart_view.dart';
import '../buyer/module/buyer_chat/bindings/buyer_chat_binding.dart';
import '../buyer/module/buyer_chat/views/buyer_chat_view.dart';
import '../buyer/module/home/bindings/buyer_home_binding.dart';
import '../buyer/module/home/views/buyer_home_view.dart';
import '../buyer/module/buyer_profile/bindings/buyer_profile_binding.dart';
import '../buyer/module/buyer_profile/views/buyer_profile_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../preferences/local_preferences.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String getInitialRoute() {
    if (LocalPreferences.box.read('token') != null &&
        LocalPreferences.box.read('token') != '') {
      final data = LocalPreferences.getCurrentLoginInfo();
      if (data.accountType == 'buyer') {
        // return buyer home screen route
        return Routes.HOME_BUYER;
      } else {
        // return seller home screen route
        return Routes.HOME_BUYER;
      }
    } else {
      // return login screen route
      return Routes.LOGIN;
    }
  }

  static final routes = [
    GetPage(
      name: _Paths.HOME_BUYER,
      page: () => const HomeViewBuyer(),
      binding: HomeBindingBuyer(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_BUYER,
      page: () => const BuyerDashboardView(),
      binding: BuyerDashboardBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_BUYER,
      page: () => const BuyerChatView(),
      binding: BuyerChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const BuyerProfileView(),
      binding: BuyerProfileBinding(),
    ),
  ];
}
