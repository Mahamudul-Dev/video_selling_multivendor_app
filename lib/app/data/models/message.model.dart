class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final String timestamp;
  MessageModel(
      {required this.message,
      required this.senderId,
      required this.receiverId,
      required this.timestamp});
}
