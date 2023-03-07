// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyUser {
  static const String collectionName = 'users';
  String? imageUrl;
  String id;
  String userName;
  String phone;
  String email;
  int? age = 0;
  int? playerHeight = 0;
  int? weight = 0;
  String? playerPosition = '';
  String? location = '';
  String? about = '';
  bool? isLiked = false;
  int? likeCounter = 0;
  double? totalRating = 0;
  double? averageRating = 0;
  List<String>? fanRating = [];
  MyUser({
    this.imageUrl = '',
    required this.id,
    required this.userName,
    required this.phone,
    required this.email,
    this.age,
    this.playerPosition,
    this.playerHeight,
    this.location,
    this.weight,
    this.about,
    this.isLiked,
    this.likeCounter,
    this.totalRating,
    this.fanRating,
    this.averageRating,
  });

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
      'averageRating':averageRating
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
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
      averageRating: double.parse(map['averageRating'].toString())
    );
  }
}
