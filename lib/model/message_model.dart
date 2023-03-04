
import 'dart:convert';

class MessageModel{
  final String meesage;
  final String sendby;
  final String time;
  final String type;

  MessageModel({
    required this.meesage,
    required this.sendby,
    required this.time,
    required this.type,});

  Map<String,dynamic > toMap(){
    return <String,dynamic> {
      'message': meesage,
      'sendby': sendby,
      'time': time,
      'type': type,
    };
  }

  factory MessageModel.fromMap(Map<String,dynamic> map){
    return MessageModel(
        meesage: map['message'] as String,
        sendby: map['sendby'] as String,
        time: map['time'] as String,
        type: map['type'] as String);
  }

  String toJson () => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String,dynamic>);
}