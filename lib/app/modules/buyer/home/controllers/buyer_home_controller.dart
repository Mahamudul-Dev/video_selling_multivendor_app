import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/modules/buyer/purchase_list/views/purchase_list_view.dart';
import 'package:video_selling_multivendor_app/services/deeplink_service.dart';
import '../../../../../../services/socket_service.dart';
import '../../../global/inbox/views/inbox_view.dart';
import '../../resource.injection.dart';
import '../../buyer_dashboard/views/buyer_dashboard_view.dart';
import '../../buyer_profile/views/buyer_profile_view.dart';

class HomeControllerBuyer extends GetxController {
  RxInt currentPage = 0.obs;

  final List<Widget> pages = [
    const BuyerDashboardView(),
    const InboxView(),
    const PurchaseListView(),
    const BuyerProfileView()
  ];


  @override
  void onInit() {
    SocketService.initializeSocket();
    super.onInit();
  }

  @override
  void onReady() async {
    await injectAllResources();
    super.onReady();
  }

  @override
  void onClose() {
    currentPage.close();
    super.onClose();
  }
}
