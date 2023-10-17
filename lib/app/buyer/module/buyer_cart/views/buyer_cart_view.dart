import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../constants/asset_maneger.dart';
import '../controllers/buyer_cart_controller.dart';

class CartView extends GetView<BuyerCartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(child: Lottie.asset(MAINTAINANCE_MOOD_ANIM)),
    );
  }
}
