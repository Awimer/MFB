// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String chatRoomId;
  final List<String> users;

  ChatRoomModel({
    required this.chatRoomId,
    required this.users,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatRoomId': chatRoomId,
      'users': users,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatRoomId: map['chatRoomId'] as String,
      users: List<String>.from((map['users'].map((e) => e))),
    );
  }
}

class MessageModel {
  final String id;
  final String message;
  final String sender;
  final String receiver;
  FieldValue? time;
  final String type;
  MessageModel(
      {required this.message,
      required this.sender,
      required this.receiver,
      this.time,
      required this.type,
      required this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'time': time,
      'type': type,
      'id': id,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
        message: map['message'] as String,
        sender: map['sender'] as String,
        receiver: map['receiver'] as String,
        type: map['type'] as String,
        id: map['id'] as String);
  }
}

class ChatModel {
  final String chatRoomId;
  final String message;
  final String lastMessageId;
  final String senderId;

  final String imageUrl;
  final String userName;
  ChatModel({
    required this.chatRoomId,
    required this.message,
    required this.lastMessageId,
    required this.senderId,
    required this.imageUrl,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatRoomId': chatRoomId,
      'message': message,
      'lastMessageId': lastMessageId,
      'senderId': senderId,
      'imageUrl': imageUrl,
      'userName': userName,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatRoomId: map['chatRoomId'] as String,
      message: map['message'] as String,
      lastMessageId: map['lastMessageId'] as String,
      senderId: map['senderId'] as String,
      imageUrl: map['imageUrl'] as String,
      userName: map['userName'] as String,
    );
  }
}
