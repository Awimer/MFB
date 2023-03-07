// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String sender;
  final String receiver;
  FieldValue? time;
  final String type;
  MessageModel({
    required this.message,
    required this.sender,
    required this.receiver,
    this.time,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'time': time,
      'type': type,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      type: map['type'] as String,
    );
  }
}
