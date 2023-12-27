import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../../connections/connections.dart';
import '../../../../../connections/message.connection.dart';
import '../../../../data/models/inbox.model.dart';
import '../../../../data/models/profile.model.dart';

class InboxController extends GetxController {
  static RxList<Inbox> chats = <Inbox>[].obs;

  // static void addChat(MessageModel message) {
  //   if (chats.isNotEmpty) {
  //     for (var i = 0; i < chats.length; i++) {
  //     if (chats[i].buyerID == message.senderId ||
  //         chats[i].sellerID == message.senderId ||
  //         chats[i].buyerID == message.receiverId ||
  //         chats[i].buyerID == message.receiverId) {

  //           chats[i].messages.add(message);
  //     } else {
  //       chats.add(ChatModel(buyerID: message.senderId!, sellerID: message.receiverId!, messages: [message].obs));
  //     }
  //   }
  //   }else{
  //     chats.add(ChatModel(buyerID: message.senderId!, sellerID: message.receiverId!, messages: [message].obs));
  //   }
  // }

  Future<void> getInbox() async {
    final response = await MessageConnection.getInbox();

    if (response.statusCode == 200) {
      chats.clear();
      try {
        final inboxData = InboxModel.fromJson(jsonDecode(response.body));
        chats.value.addAll(inboxData.inbox ?? []);
      } catch (e) {
        Logger().e(e);
      }
    }
  }


  Future<ProfileModel?> getProfileInfo(String? id) async {
    ProfileModel? profile;
    if (id != null) {
      final response = await ProfileConnection.userProfileConnection(id: id);
    if (response.statusCode == 200) {
      profile = ProfileModel.fromJson(jsonDecode(response.body));
    } 
    }
    return profile;
  }
}
