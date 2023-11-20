import 'message.model.dart';

class ChatModel {
  final String buyerID;
  final String sellerID;
  final List<MessageModel> messages;
  ChatModel({
    required this.buyerID,
    required this.sellerID,
    required this.messages,
  });
}
