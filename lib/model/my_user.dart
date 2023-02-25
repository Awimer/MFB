class MyUser {
  static const String collectionName = 'users';
  String? id;
  String? userName;
  String? phone;
  String? email;

  MyUser({this.id,this.userName,this.phone,this.email});

  MyUser.fromFireStore(Map<String,dynamic>data)
  :this (
    id: data ['id'],
    userName: data ['userName'],
    phone: data ['phone'],
    email: data ['email'],
  );

  Map<String,dynamic> toFireStore(){
    return {
      'id' :id,
      'userName' :userName,
      'phone' :phone,
      'email' :email,
    };
  }
}