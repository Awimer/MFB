class MessageModel {
  final String message;
  final String sendby;
  final String time;
  final String type;

  MessageModel({
    required this.message,
    required this.sendby,
    required this.time,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sendby': sendby,
      'time': time,
      'type': type,
    };
  }

   factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      sendby: map['sendby'] as String,
      time: map['time'] as String,
      type: map['type'] as String,
    );
  }
}
