import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mfb/model/player_model.dart';

class MyDataBase {
  static CollectionReference<PlayerModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(PlayerModel.collectionName)
        .withConverter<PlayerModel>(
            fromFirestore: (doc, _) => PlayerModel.fromMap(doc.data()!),
            toFirestore: (user, options) => user.toMap());
  }

  static Future<PlayerModel?> insertUser(PlayerModel user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    var res = await docRef.set(user);
    return user;
  }

  static Future<PlayerModel?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static Future<QuerySnapshot<PlayerModel>> getAllUsers() async {
    // read data once
    return await getUsersCollection().get();
  }

  static Stream<QuerySnapshot<PlayerModel>> listenForMyUsersRealTimeUpdates() {
    // listen for real time updates
    return getUsersCollection().snapshots();
  }
}
