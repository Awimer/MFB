// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mfb/model/parent_model.dart';

class PlayerModel extends UserModel {
  static const String collectionName = 'users';
  int? playerHeight = 0;
  int? weight = 0;
  String? playerPosition = '';
  String? about = '';
  bool? isLiked = false;
  int? likeCounter = 0;
  double? totalRating = 0;
  double? averageRating = 0;
  List<String>? fanRating = [];
  String currentClube;
  String favoritePlane;

  PlayerModel(
      {this.playerPosition,
      this.playerHeight,
      this.weight,
      this.about,
      this.isLiked,
      this.likeCounter,
      this.totalRating,
      this.fanRating,
      this.averageRating,
      required super.imageUrl,
      required super.id,
      required super.userName,
      required super.phone,
      required super.email,
      required super.location,
      required super.age,
      required super.userType,
      required this.currentClube,
      required this.favoritePlane});

  @override
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
      'weight': weight,
      'about': about,
      'liked': isLiked,
      'likeCounter': likeCounter,
      'totalRating': totalRating,
      'fanRating': fanRating,
      'averageRating': averageRating,
      'userType': userType,
      'currentClube': currentClube,
      'favoritePlane': favoritePlane
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
        imageUrl: map['imageUrl'].toString(),
        id: map['id'].toString(),
        userName: map['userName'].toString(),
        phone: map['phone'].toString(),
        email: map['email'].toString(),
        age: int.parse(map['age'].toString()),
        playerPosition: map['playerPosition'] as String,
        playerHeight: int.parse(map['playerHeight'].toString()),
        location: map['location'].toString(),
        weight: int.parse(map['weight'].toString()),
        about: map['about'].toString(),
        isLiked: map['liked'] as bool ?? false,
        likeCounter: int.parse(map['likeCounter'].toString()),
        totalRating: double.parse(map['totalRating'].toString()),
        fanRating: List<String>.from(map['fanRating'].map((e) => e.toString())),
        averageRating: double.parse(map['averageRating'].toString()),
        userType: map['userType'] as String,
        favoritePlane: map['favoritePlane'] as String,
        currentClube: map['currentClube'] as String);
  }
}
