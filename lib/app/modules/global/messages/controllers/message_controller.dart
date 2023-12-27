import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:video_selling_multivendor_app/app/preferences/local_preferences.dart';
import 'package:video_selling_multivendor_app/services/socket_service.dart';

import '../../../../../connections/message.connection.dart';
import '../../../../data/models/message.model.dart';

class MessageController extends GetxController {
  final TextEditingController messageTextController = TextEditingController();
  late final String sellerId;
  RxList<Message> messages = <Message>[].obs;

  Future<void> getConversations(String participantId) async {

    final response = await MessageConnection.getMessages(participantId);

    if (response.statusCode == 200) {
      messages.value.clear();
      try {
        final data = MessageModel.fromJson(response.data);
        if (data.messages != null) {
          for (var i = 0; i < data.messages!.length; i++) {
          messages.value.insert(0, data.messages![i]);
        }
        }
      } catch (e) {
        Logger().e(e);
      }
    }
  }

  Future<void> sendMessage(String receiverId) async {
    final message = Message(
            message: messageTextController.text,
            senderId: LocalPreferences.getCurrentLoginInfo().id!,
            receiverId: receiverId,
            createdAt: DateTime.now());

    SocketService.socket.emit('privateMessage', message.toJson());
    messages.insert(
        0,message);
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
