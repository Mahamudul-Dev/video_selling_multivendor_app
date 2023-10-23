import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../constants/asset_maneger.dart';
import '../../../components/cart_item_card.dart';
import '../controllers/buyer_cart_controller.dart';

class CartView extends GetView<BuyerCartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() => controller.cartItems.isEmpty
          ? Center(child: Lottie.asset(NO_CART_ANIM))
          : ListView.separated(
              padding: const EdgeInsets.all(18),
              itemBuilder: (context, index) {
                return CartItemCard(
                  productName: controller.cartItems[index].title ?? '',
                  authorName: controller.cartItems[index].author?.name ?? '',
                  productImage: controller.cartItems[index].thumbnail ?? '',
                  price: controller.cartItems[index].price ?? '',
                  onRemovePress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: SECONDARY_APP_COLOR)),
                            actions: [
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.green)),
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    'No',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: Colors.white),
                                  )),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red)),
                                  onPressed: () =>
                                      controller.removeToCart(index),
                                  child: Text(
                                    'Yes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: Colors.white),
                                  ))
                            ],
                          );
                        });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: controller.cartItems.length)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text('Total (${controller.cartItems.length} items)')),
                Obx(() => controller.cartItems.isNotEmpty
                    ? Text('\$${controller.totalCartItemPrice}')
                    : const Text('\$00.00'))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () => controller.checkout(),
              child: Container(
                height: 60,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: SECONDARY_APP_COLOR,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proceed to Checkout',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: SECONDARY_APP_COLOR,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
