import 'dart:convert';

import 'message.model.dart';

InboxModel inboxModelFromJson(String str) => InboxModel.fromJson(json.decode(str));

String inboxModelToJson(InboxModel data) => json.encode(data.toJson());

class InboxModel {
    String? message;
    List<Inbox>? inbox;

    InboxModel({
        this.message,
        this.inbox,
    });

    factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
        message: json["message"],
        inbox: json["inbox"] == null ? [] : List<Inbox>.from(json["inbox"]!.map((x) => Inbox.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "inbox": inbox == null ? [] : List<dynamic>.from(inbox!.map((x) => x.toJson())),
    };
}

class Inbox {
    String? id;
    Participants? participants;
    Message? lastMessage;

    Inbox({
        this.id,
        this.participants,
        this.lastMessage,
    });

    factory Inbox.fromJson(Map<String, dynamic> json) => Inbox(
        id: json["_id"],
        participants: json["participants"] == null ? null : Participants.fromJson(json["participants"]),
        lastMessage: json["lastMessage"] == null ? null : Message.fromJson(json["lastMessage"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "participants": participants?.toJson(),
        "lastMessage": lastMessage?.toJson(),
    };
}

class Participants {
    String? participant1;
    String? participant2;

    Participants({
        this.participant1,
        this.participant2,
    });

    factory Participants.fromJson(Map<String, dynamic> json) => Participants(
        participant1: json["participant1"],
        participant2: json["participant2"],
    );

    Map<String, dynamic> toJson() => {
        "participant1": participant1,
        "participant2": participant2,
    };
}