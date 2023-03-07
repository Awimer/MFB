class MessageModel {
  final String message;
  final String sender;
  final String receiver;
  final String time;
  final String type;
  final int sort;
  MessageModel({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.time,
    required this.type,
    required this.sort,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'time': time,
      'type': type,
      'sort': sort
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      time: map['time'] as String,
      type: map['type'] as String,
      sort: int.parse(map['sort'].toString()),
    );
  }
}
