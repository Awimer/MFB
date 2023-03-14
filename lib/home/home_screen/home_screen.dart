import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/home_screen/popular_player_item.dart';
import 'package:mfb/model/player_model.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../player details/player_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final collectionStream = FirebaseFirestore.instance
      .collection(PlayerModel.collectionName)
      .snapshots();

  final searchBar = TextEditingController();
  String searchValue = '';
  bool isSearch = false;

  final space = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: usersCollection.doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(child: Text('There is an error'));
          }
          if (snapshot.hasData) {
            final userData = PlayerModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleSpacing: 20,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    userData.imageUrl == ''
                        ? const CircleAvatar(
                            radius: 23,
                            foregroundImage:
                                AssetImage('assets/images/player.png'),
                          )
                        : CircleAvatar(
                            radius: 23,
                            foregroundImage: NetworkImage(userData.imageUrl),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${userData.userName}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Explore The Best Player in the world',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_outlined),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SearchBarAnimation(
                      textEditingController: searchBar,
                      isOriginalAnimation: false,
                      onFieldSubmitted: (String value) {
                        debugPrint('onFieldSubmitted value $value');
                      },
                      onPressButton: (value) {
                        setState(() {
                          isSearch = value;
                          // searchValue = '';
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          searchValue = value;
                        });
                      },
                      buttonWidget: const Icon(Icons.search),
                      secondaryButtonWidget: const Icon(Icons.cancel),
                      trailingWidget: const Icon(
                        Icons.search,
                      ),
                    ),
                    isSearch ? _buildSearchResult() : _buildHomeWidget(),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildHomeWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Category',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 100.0,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildCategoryItem(),
              separatorBuilder: (context, index) => const SizedBox(
                width: 20.0,
              ),
              itemCount: 4,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Players',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
          const PopularPlayerItem(),
        ],
      ),
    );
  }

  Widget _buildSearchResult() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('userName', isEqualTo: searchValue)
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
                                      child: likeButton(user),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }).toList(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: Text('User Not found'));
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
        } else if (!isLiked) {
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

  Widget buildCategoryItem() => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const Material(elevation: 10.0, color: Colors.grey),
            Image.asset(
              'assets/images/striker_category.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            Container(
              height: 30,
              width: 100.0,
              color: Theme.of(context).buttonColor,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                  child: Text(
                'Goal Keeper',
                style: Theme.of(context).textTheme.bodyText2,
              )),
            ),
          ],
        ),
      );
}
