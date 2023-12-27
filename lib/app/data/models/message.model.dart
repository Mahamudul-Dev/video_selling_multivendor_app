import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    List<Message>? messages;

    MessageModel({
        this.messages,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    };
}

class Message {
    String? id;
    String? message;
    String? senderId;
    String? receiverId;
    DateTime? createdAt;
    int? v;

    Message({
        this.id,
        this.message,
        this.senderId,
        this.receiverId,
        this.createdAt,
        this.v,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        message: json["message"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "senderId": senderId,
        "receiverId": receiverId,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
    };
}