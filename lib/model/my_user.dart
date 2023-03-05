class MyUser {
  static const String collectionName = 'users';
  String id;
  String userName;
  String phone;
  String email;

  MyUser({
    required this.id,
    required this.userName,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'phone': phone,
      'email': email,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] as String,
      userName: map['userName'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
    );
  }
}
