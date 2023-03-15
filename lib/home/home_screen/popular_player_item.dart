import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/player%20details/player_details.dart';
import 'package:sizer/sizer.dart';

import '../../model/player_model.dart';

class PopularPlayerItem extends StatelessWidget {
  PopularPlayerItem({super.key});

  final Map<String, List<String>> position = {
    'goal keepers': ['GK'],
    'midfielders': ['CDM', 'CM', 'CAM'],
    'defenders': ['CB', 'RB', 'LB'],
    'attackers': ['RW', 'LW', 'ST']
  };

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 7);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('userType', isEqualTo: 'player')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(child: Text('There is an error'));
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView(
                children: snapshot.data!.docs.map((doc) {
                  final user =
                      PlayerModel.fromMap(doc.data() as Map<String, dynamic>);
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
                            Expanded(
                              child: user.imageUrl == ''
                                  ? Image.asset(
                                      'assets/images/player.png',
                                      width: 20.w,
                                      height: 20.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      user.imageUrl,
                                      width: 20.w,
                                      height: 20.h,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        Text(
                                          '${user.currentClube} (current clube)',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
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
                }).toList(),
              ),
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
