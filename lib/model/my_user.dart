import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyUser {
  static const String collectionName = 'users';
  String? imageUrl;
  String id;
  String userName;
  String phone;
  String email;
  int age;
  int playerHeight;
  int weight;
  String? playerPosition;
  String? location;
  MyUser(
      {this.imageUrl,
      required this.id,
      required this.userName,
      required this.phone,
      required this.email,
      this.age = 0,
      this.playerPosition,
      this.playerHeight = 0,
      this.location,
      this.weight = 0});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'id': id,
      'userName': userName,
      'phone': phone,
      'email': email,
      'age': age,
      'playerPosition': playerPosition,
      'playerHeight': playerHeight,
      'location': location,
      'weight': weight
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      imageUrl: map['imageUrl'].toString(),
      id: map['id'].toString(),
      userName: map['userName'].toString(),
      phone: map['phone'].toString(),
      email: map['email'].toString(),
      age: map['age'] != null ? int.parse(map['age'].toString()) : 0,
      playerPosition:
          map['playerPosition'] != null ? map['playerPosition'] as String : '',
      playerHeight: map['playerHeight'] != null
          ? int.parse(map['playerHeight'].toString())
          : 0,
      location: map['location'].toString(),
      weight: map['weight'] != null ? int.parse(map['weight'].toString()) : 0,
    );
  }
}
