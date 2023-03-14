import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/model/player_model.dart';
import 'package:mfb/player%20details/player_details.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'category screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Map<String, List<String>> position = {
    'goal keepers': ['GK'],
    'midfielders': ['CDM', 'CM', 'CAM'],
    'defenders': ['CB', 'RB', 'LB'],
    'attackers': ['RW', 'LW', 'ST']
  };
  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    const space = SizedBox(height: 7);
    print(position[title]);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                  children: snapshot.data!.docs.map((doc) {
                final user =
                    PlayerModel.fromMap(doc.data() as Map<String, dynamic>);
                if (user.id != FirebaseAuth.instance.currentUser!.uid &&
                    position[title]!.contains(user.playerPosition)) {
                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, PlayerDetails.routeName,
                        arguments: user.id),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).cardColor),
                      child: Row(
                        children: [
                          user.imageUrl == ''
                              ? Image.asset('assets/images/player.png',
                                  width: 20.w, height: 20.h, fit: BoxFit.cover)
                              : Image.network(
                                  user.imageUrl,
                                  width: 20.w,
                                  height: 20.h,
                                ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                space,
                                Text(user.userName),
                                space,
                                Text(
                                  user.age.toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                space,
                                Text(
                                  user.playerPosition!,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey,
                                        size: 21,
                                      ),
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: likeButton(user)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              }).toList()),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget likeButton(user) {
    return FavoriteButton(
      iconSize: 40,
      isFavorite: user.isLiked,
      valueChanged: (isLiked) {
        if (isLiked) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.id)
              .update(<String, dynamic>{
            'liked': isLiked,
            'likeCounter': ++user.likeCounter
          });
          user.isLiked = isLiked;
          FirebaseFirestore.instance
              .collection('favorites')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Favorite')
              .doc(user.id)
              .set(user.toMap());
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.id)
              .update(<String, dynamic>{
            'liked': isLiked,
            'likeCounter': --user.likeCounter
          });
          FirebaseFirestore.instance
              .collection('favorites')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Favorite')
              .doc(user.id)
              .delete();
        }
      },
    );
  }
}
