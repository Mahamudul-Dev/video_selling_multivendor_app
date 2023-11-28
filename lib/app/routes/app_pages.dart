import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../buyer/module/buyer_cart/bindings/buyer_cart_binding.dart';
import '../buyer/module/buyer_cart/views/buyer_cart_view.dart';
import '../buyer/module/buyer_chat/bindings/buyer_chat_binding.dart';
import '../buyer/module/buyer_chat/views/buyer_chat_view.dart';
import '../buyer/module/buyer_dashboard/bindings/buyer_dashboard_binding.dart';
import '../buyer/module/buyer_dashboard/views/buyer_dashboard_view.dart';
import '../buyer/module/buyer_message/bindings/buyer_message_binding.dart';
import '../buyer/module/buyer_message/views/buyer_message_view.dart';
import '../buyer/module/buyer_product_details/bindings/buyer_product_details_binding.dart';
import '../buyer/module/buyer_product_details/views/buyer_product_details_view.dart';
import '../buyer/module/buyer_products/bindings/buyer_products_binding.dart';
import '../buyer/module/buyer_products/views/buyer_products_view.dart';
import '../buyer/module/buyer_profile/bindings/buyer_profile_binding.dart';
import '../buyer/module/buyer_profile/views/buyer_profile_edit_view.dart';
import '../buyer/module/buyer_profile/views/buyer_profile_view.dart';
import '../buyer/module/home/bindings/buyer_home_binding.dart';
import '../buyer/module/home/views/buyer_home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../preferences/local_preferences.dart';
import '../seller/modules/create_product/bindings/create_product_binding.dart';
import '../seller/modules/create_product/views/create_product_view.dart';
import '../seller/modules/product_details/bindings/product_details_binding.dart';
import '../seller/modules/product_details/views/product_details_view.dart';
import '../seller/modules/seller_dashboard/bindings/seller_dashboard_binding.dart';
import '../seller/modules/seller_dashboard/views/seller_dashboard_view.dart';
import '../seller/modules/seller_home/bindings/seller_home_binding.dart';
import '../seller/modules/seller_home/views/seller_home_view.dart';
import '../seller/modules/seller_inbox/bindings/seller_inbox_binding.dart';
import '../seller/modules/seller_inbox/views/seller_inbox_view.dart';
import '../seller/modules/seller_notification/bindings/seller_notification_binding.dart';
import '../seller/modules/seller_notification/views/seller_notification_view.dart';
import '../seller/modules/seller_profile/bindings/seller_profile_binding.dart';
import '../seller/modules/seller_profile/views/seller_profile_view.dart';
import '../seller/modules/wallet/bindings/wallet_binding.dart';
import '../seller/modules/wallet/views/wallet_view.dart';
import '../seller/modules/wallet_history/bindings/wallet_history_binding.dart';
import '../seller/modules/wallet_history/views/wallet_history_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String getInitialRoute() {
    final data = LocalPreferences.getCurrentLoginInfo();
    Logger().i({'Account Type': data.accountType});
    if (data.token != null && data.accountType != null) {
      if (data.accountType == 'Buyer') {
        return Routes.HOME_BUYER;
      } else {
        Logger().i({'Account Type': data.accountType});
        return Routes.SELLER_HOME;
      }
    } else {
      return Routes.LOGIN;
    }
  }

  static final routes = [
    /// *** Buyer App Pages *** //
    ///
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
      page: () => RegisterView(),
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
      name: _Paths.Buyer_PROFILE,
      page: () => const BuyerProfileView(),
      binding: BuyerProfileBinding(),
    ),
    GetPage(
      name: _Paths.Buyer_PROFILE_EDIT,
      page: () => const BuyerProfileEditView(),
      binding: BuyerProfileBinding(),
    ),
    GetPage(
      name: _Paths.BUYER_MESSAGE,
      page: () => const BuyerMessageView(),
      binding: BuyerMessageBinding(),
    ),
    GetPage(
      name: _Paths.BUYER_PRODUCTS,
      page: () => BuyerProductsView(),
      binding: BuyerProductsBinding(),
    ),
    GetPage(
        name: _Paths.BUYER_PRODUCT_DETAILS,
        page: () => BuyerProductDetailsView(),
        binding: BuyerProductDetailsBinding()),

    /// *** Seller App Pages *** //
    GetPage(
      name: _Paths.SELLER_DASHBOARD,
      page: () => const SellerDashboardView(),
      binding: SellerDashboardBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_INBOX,
      page: () => const SellerInboxView(),
      binding: SellerInboxBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_PROFILE,
      page: () => const SellerProfileView(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PRODUCT,
      page: () => const CreateProductView(),
      binding: CreateProductBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_NOTIFICATION,
      page: () => const SellerNotificationView(),
      binding: SellerNotificationBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_HOME,
      page: () => const SellerHomeView(),
      bindings: [
        SellerHomeBinding(),
        SellerDashboardBinding(),
        WalletBinding(),
        SellerInboxBinding(),
        SellerProfileBinding()
      ],
    ),
    GetPage(
      name: _Paths.WALLET_HISTORY,
      page: () => WalletHistoryView(),
      binding: WalletHistoryBinding(),
    ),
  ];
}
