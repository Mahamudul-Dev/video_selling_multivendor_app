import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/seller/modules/seller_dashboard/views/seller_dashboard_view.dart';
import '../../../../buyer/module/buyer_dashboard/views/buyer_dashboard_view.dart';
import '../../seller_inbox/views/seller_inbox_view.dart';
import '../../seller_profile/views/seller_profile_view.dart';
import '../../wallet/views/wallet_view.dart';

class SellerHomeController extends GetxController {
  RxInt currentPage = 0.obs;
  List<Widget> pages = [
    const SellerDashboardView(),
    const WalletView(),
    const SellerInboxView(),
    const SellerProfileView()
  ];

  @override
  void onClose() {
    currentPage.close();
    super.onClose();
  }
}
