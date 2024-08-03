import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
    String? chat;
    String? from;
    String? receiverId;
    String? senderId;
    DateTime? timeStamp;

    ChatModel({
        this.chat,
        this.from,
        this.receiverId,
        this.senderId,
        this.timeStamp,
    });

    factory ChatModel.fromRawJson(String str) => ChatModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chat: json["chat"],
        from: json["from"],
        receiverId: json["receiverId"],
        senderId: json["senderId"],
        timeStamp: json["timeStamp"] is Timestamp ? json["timeStamp"].toDate() : null,
    );

    Map<String, dynamic> toJson() => {
        "chat": chat,
        "from": from,
        "receiverId": receiverId,
        "senderId": senderId,
        "timeStamp": timeStamp,
    };
}
