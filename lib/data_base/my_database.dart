import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mfb/model/my_user.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (doc, _) => MyUser.fromMap(doc.data()!),
            toFirestore: (user, options) => user.toMap());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    var res = await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static Future<QuerySnapshot<MyUser>> getAllUsers() async {
    // read data once
    return await getUsersCollection().get();
  }

  static Stream<QuerySnapshot<MyUser>> listenForMyUsersRealTimeUpdates() {
    // listen for real time updates
    return getUsersCollection().snapshots();
  }
}
