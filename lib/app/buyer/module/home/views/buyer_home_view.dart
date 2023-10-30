import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:video_selling_multivendor_app/app/buyer/module/buyer_cart/controllers/buyer_cart_controller.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/buyer_home_controller.dart';

class HomeViewBuyer extends GetView<HomeControllerBuyer> {
  const HomeViewBuyer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(APP_NAME),
      //   actions: [
      //     IconButton(
      //         style: ButtonStyle(
      //             backgroundColor:
      //                 MaterialStatePropertyAll(Colors.grey.shade800)),
      //         onPressed: () {},
      //         icon: const Icon(
      //           Icons.search_rounded,
      //           color: Colors.white,
      //         )),
      //     Stack(
      //       children: [
      //         IconButton(
      //             style: ButtonStyle(
      //                 backgroundColor:
      //                     MaterialStatePropertyAll(Colors.grey.shade800)),
      //             onPressed: () => Get.toNamed(Routes.CART),
      //             icon: const Icon(
      //               Icons.shopping_bag_outlined,
      //               color: Colors.white,
      //             )),
      //         Positioned(
      //           bottom: 2,
      //           right: 2,
      //           child: Container(
      //             padding: const EdgeInsets.all(3),
      //             decoration: const BoxDecoration(
      //               shape: BoxShape.circle,
      //               color: Colors.black,
      //             ),
      //             child: Center(
      //                 child: Obx(() =>
      //                     Get.find<BuyerCartController>().cartItems.isNotEmpty
      //                         ? Text(
      //                             Get.find<BuyerCartController>()
      //                                 .cartItems
      //                                 .length
      //                                 .toString(),
      //                             style: Theme.of(context)
      //                                 .textTheme
      //                                 .bodySmall
      //                                 ?.copyWith(color: Colors.white),
      //                           )
      //                         : Text(
      //                             '0',
      //                             style: Theme.of(context)
      //                                 .textTheme
      //                                 .bodySmall
      //                                 ?.copyWith(color: Colors.white),
      //                           ))),
      //           ),
      //         )
      //       ],
      //     ),
      //     const SizedBox(
      //       width: 10,
      //     )
      //   ],
      // ),
      body: Obx(() => controller.pages[controller.currentPage.value]),
      bottomNavigationBar: Container(
        color: SECONDARY_APP_COLOR,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: GNav(
            backgroundColor: SECONDARY_APP_COLOR,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(10),
            gap: 8,
            onTabChange: (index) {
              controller.currentPage.value = index;
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.message,
                text: 'Chats',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profile',
              )
            ]),
      ),
    );
  }
}
