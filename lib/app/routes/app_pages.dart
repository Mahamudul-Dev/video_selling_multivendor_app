import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/preferences/local_preferences.dart';
import '../modules/buyer/author_profile/bindings/author_profile_binding.dart';
import '../modules/buyer/author_profile/views/author_profile_view.dart';
import '../modules/buyer/buyer_cart/bindings/buyer_cart_binding.dart';
import '../modules/buyer/buyer_cart/views/buyer_cart_view.dart';
import '../modules/buyer/buyer_dashboard/bindings/buyer_dashboard_binding.dart';
import '../modules/buyer/buyer_dashboard/views/buyer_dashboard_view.dart';
import '../modules/buyer/buyer_product_details/bindings/buyer_product_details_binding.dart';
import '../modules/buyer/buyer_product_details/views/buyer_product_details_view.dart';
import '../modules/buyer/buyer_products/bindings/buyer_products_binding.dart';
import '../modules/buyer/buyer_products/views/buyer_products_view.dart';
import '../modules/buyer/buyer_profile/bindings/buyer_profile_binding.dart';
import '../modules/buyer/buyer_profile/views/buyer_profile_edit_view.dart';
import '../modules/buyer/buyer_profile/views/buyer_profile_view.dart';
import '../modules/buyer/favorite_list/bindings/favorite_list_binding.dart';
import '../modules/buyer/favorite_list/views/favorite_list_view.dart';
import '../modules/buyer/home/bindings/buyer_home_binding.dart';
import '../modules/buyer/home/views/buyer_home_view.dart';
import '../modules/buyer/purchase_list/bindings/purchase_list_binding.dart';
import '../modules/buyer/purchase_list/views/purchase_list_view.dart';
import '../modules/buyer/subscribed_creator_list/bindings/subscribed_creator_list_binding.dart';
import '../modules/buyer/subscribed_creator_list/views/subscribed_creator_list_view.dart';
import '../modules/buyer/wish_list/bindings/wish_list_binding.dart';
import '../modules/buyer/wish_list/views/wish_list_view.dart';
import '../modules/global/inbox/bindings/inbox_binding.dart';
import '../modules/global/inbox/views/inbox_view.dart';
import '../modules/global/login/bindings/login_binding.dart';
import '../modules/global/login/views/login_view.dart';
import '../modules/global/messages/bindings/message_binding.dart';
import '../modules/global/messages/views/message_view.dart';
import '../modules/global/notification/bindings/notification_binding.dart';
import '../modules/global/notification/views/notification_view.dart';
import '../modules/global/register/bindings/register_binding.dart';
import '../modules/global/register/views/register_view.dart';
import '../modules/global/support_chat/bindings/support_chat_binding.dart';
import '../modules/global/support_chat/views/support_chat_view.dart';
import '../modules/global/video_player/bindings/video_player_binding.dart';
import '../modules/global/video_player/views/video_player_view.dart';
import '../modules/seller/create_product/bindings/create_product_binding.dart';
import '../modules/seller/create_product/views/create_product_view.dart';
import '../modules/seller/product_details/bindings/product_details_binding.dart';
import '../modules/seller/product_details/views/product_details_view.dart';
import '../modules/seller/seller_dashboard/bindings/seller_dashboard_binding.dart';
import '../modules/seller/seller_dashboard/views/seller_dashboard_view.dart';
import '../modules/seller/seller_home/bindings/seller_home_binding.dart';
import '../modules/seller/seller_home/views/seller_home_view.dart';
import '../modules/seller/seller_notification/bindings/seller_notification_binding.dart';
import '../modules/seller/seller_notification/views/seller_notification_view.dart';
import '../modules/seller/seller_profile/bindings/seller_profile_binding.dart';
import '../modules/seller/seller_profile/views/seller_profile_view.dart';
import '../modules/seller/wallet/bindings/wallet_binding.dart';
import '../modules/seller/wallet/views/wallet_view.dart';
import '../modules/seller/wallet_history/bindings/wallet_history_binding.dart';
import '../modules/seller/wallet_history/views/wallet_history_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String getInitialRoute() {
    final data = LocalPreferences.getCurrentLoginInfo();
    Logger().i({'Account Type': data.accountType});
    if (data.token != null && data.accountType != null) {
      if (data.accountType == 'Buyer') {
        return Routes.HOME_BUYER;
      } else if (data.accountType == 'Seller') {
        Logger().i({'Account Type': data.accountType});
        return Routes.SELLER_HOME;
      } else {
        return Routes.LOGIN;
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
      name: _Paths.INBOX,
      page: () => const InboxView(),
      binding: InboxBinding(),
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
      name: _Paths.MESSAGE,
      page: () => MessageView(),
      binding: MessageBinding(),
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
      page: () => ProductDetailsView(),
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
        InboxBinding(),
        SellerProfileBinding()
      ],
    ),
    GetPage(
      name: _Paths.WALLET_HISTORY,
      page: () => WalletHistoryView(),
      binding: WalletHistoryBinding(),
    ),
    GetPage(
      name: _Paths.AUTHOR_PROFILE,
      page: () => AuthorProfileView(),
      binding: AuthorProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT_CHAT,
      page: () => const SupportChatView(),
      binding: SupportChatBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE_LIST,
      page: () => const FavoriteListView(),
      binding: FavoriteListBinding(),
    ),
    GetPage(
      name: _Paths.WISH_LIST,
      page: () => const WishListView(),
      binding: WishListBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIBED_CREATOR_LIST,
      page: () => const SubscribedCreatorListView(),
      binding: SubscribedCreatorListBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE_LIST,
      page: () => const PurchaseListView(),
      binding: PurchaseListBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PLAYER,
      page: () => VideoPlayerView(),
      binding: VideoPlayerBinding(),
    ),
  ];
}
