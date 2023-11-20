import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../../../components/bottom_navbar.components.dart';
import '../controllers/seller_home_controller.dart';

class SellerHomeView extends GetView<SellerHomeController> {
  const SellerHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DARK_ASH,
      body: Obx(() => controller.pages[controller.currentPage.value]),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.white, shape: const CircleBorder(), onPressed: (){}, child: const Icon(Icons.add, color: SECONDARY_APP_COLOR, size: 35,),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
