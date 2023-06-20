// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mfb/model/parent_model.dart';
import 'package:mfb/model/rate_skil_model.dart';

class PlayerModel extends UserModel {
  static const String collectionName = 'users';
  int playerHeight = 0;
  int? weight = 0;
  String? playerPosition = '';
  String? about = '';
  bool? isLiked = false;
  int? likeCounter = 0;
  RateSkilModel totalRateSkil;
  RateSkilModel averageRateSkil;
  List<String>? fanRating = [];
  String currentClube;
  String favoritePlane;

  PlayerModel(
      {this.playerPosition,
      required this.playerHeight,
      this.weight,
      this.about,
      this.isLiked,
      this.likeCounter,
      this.fanRating,
      required super.imageUrl,
      required super.id,
      required super.userName,
      required this.totalRateSkil,
      required this.averageRateSkil,
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
      'totalRateSkil': totalRateSkil,
      'averageRateSkil': averageRateSkil,
      'likeCounter': likeCounter,
      'fanRating': fanRating,
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
        isLiked: map['liked'] as bool,
        totalRateSkil: map['totalRateSkil'],
        averageRateSkil: map['averageRateSkil'],
        likeCounter: int.parse(map['likeCounter'].toString()),
        fanRating: List<String>.from(map['fanRating'].map((e) => e.toString())),
        userType: map['userType'] as String,
        favoritePlane: map['favoritePlane'] as String,
        currentClube: map['currentClube'] as String);
  }
}
