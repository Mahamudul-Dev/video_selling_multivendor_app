import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/message.model.dart';

class BuyerMessageController extends GetxController {
  final TextEditingController messageTextController = TextEditingController();
  late final String sellerId;
  RxList<MessageModel> messages = <MessageModel>[].obs;

  Future<void> getConversations() async {}

  Future<void> sendMessage() async {
    messages.insert(
        0,
        MessageModel(
            message: messageTextController.text,
            senderId: '1234',
            receiverId: sellerId,
            timestamp: DateTime.now().toString()));
    messageTextController.clear();
  }

  @override
  void onInit() {
    sellerId = '4321';
    super.onInit();
  }

  @override
  void onClose() {
    messageTextController.dispose();
    super.onClose();
  }
}
