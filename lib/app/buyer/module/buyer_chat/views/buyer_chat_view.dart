import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/asset_maneger.dart';
import '../controllers/buyer_chat_controller.dart';

class BuyerChatView extends GetView<BuyerChatController> {
  const BuyerChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset(MAINTAINANCE_MOOD_ANIM)),
    );
  }
}
