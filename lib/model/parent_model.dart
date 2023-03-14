// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String imageUrl;
  String id;
  String userName;
  String phone;
  String email;
  String location;
  int age;
  String userType;
  UserModel({
    required this.imageUrl,
    required this.id,
    required this.userName,
    required this.phone,
    required this.email,
    required this.location,
    required this.age,
    required this.userType
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'id': id,
      'userName': userName,
      'phone': phone,
      'email': email,
      'location': location,
      'age': age,
      'userType': userType
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      imageUrl: map['imageUrl'] as String,
      id: map['id'] as String,
      userName: map['userName'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      location: map['location'] as String,
      age: map['age'] as int,
      userType: map['userType'] as String 
    );
  }
}
