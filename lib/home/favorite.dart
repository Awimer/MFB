import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/my_user.dart';
import '../player details/player_details.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 7);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('favorites')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Favorite')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(child: Text('There is an error'));
          } else if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                final user = MyUser.fromMap(doc.data() as Map<String, dynamic>);
                if (user.id != FirebaseAuth.instance.currentUser!.uid) {
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
                              ? Image.asset('assets/images/player.png')
                              : Image.network(
                                  user.imageUrl!,
                                  width: 100,
                                  height: 100,
                                ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
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
                              const Text(
                                'Striker',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                    size: 21,
                                  ),
                                  Text(
                                    user.location!,
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
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text('No Favorite yet!'),
                );
              }).toList(),
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget likeButton(user) {
    return FavoriteButton(
      iconSize: 40,
      isFavorite: user.isLiked,
      valueChanged: (isLiked) {
        if (!isLiked) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.id)
              .update(<String, dynamic>{
            'liked': isLiked,
            'likeCounter': --user.likeCounter
          });
          user.isLiked = isLiked;
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
