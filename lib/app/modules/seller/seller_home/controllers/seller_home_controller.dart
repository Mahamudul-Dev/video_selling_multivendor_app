import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../../services/socket_service.dart';
import '../../../global/inbox/views/inbox_view.dart';
import '../../seller_dashboard/views/seller_dashboard_view.dart';
import '../../seller_profile/views/seller_profile_view.dart';
import '../../wallet/views/wallet_view.dart';

class SellerHomeController extends GetxController {
  RxInt currentPage = 0.obs;
  List<Widget> pages = [
    const SellerDashboardView(),
    const WalletView(),
    const InboxView(),
    const SellerProfileView()
  ];

  @override
  void onClose() {
    currentPage.close();
    super.onClose();
  }

  @override
  void onInit() {
    SocketService.initializeSocket();
    super.onInit();
  }
}
