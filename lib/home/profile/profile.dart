import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mfb/core/components/action_button.dart';
import 'package:mfb/home/profile/post_media.dart';
import 'package:mfb/home/profile/profile_modify.dart';
import 'package:mfb/model/post_model.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../model/player_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(226, 0, 48, 1),
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          fabButtons: <Widget>[
            ActionButton(
              icon: const Icon(Icons.insert_photo),
              onPressed: () {
                Navigator.pushNamed(context, PostMedia.routeName);
              },
            ),
            ActionButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, ProfileModify.routeName);
              },
            )
          ],
          key: widget.key,
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final userData = PlayerModel.fromMap(
                  snapshot.data!.data() as Map<String, dynamic>);
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      userData.imageUrl == ''
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/circle_avater.png'),
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 40,
                                foregroundImage:
                                    AssetImage('assets/images/player.png'),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/circle_avater.png'),
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                foregroundImage:
                                    NetworkImage(userData.imageUrl),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildCardDetails(userData),
                      userData.userType != 'fan'
                          ? _buildMedia()
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container();
          }),
    );
  }

  _buildCardDetails(PlayerModel userData) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Colors.grey,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userData.userName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                userData.userType == 'player'
                    ? Text(
                        '( ${userData.playerPosition!} )',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userData.userType == 'player'
                        ? Text(
                            '${userData.age} (year)',
                            style: const TextStyle(color: Colors.grey),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData.userType == 'player'
                          ? '${userData.playerHeight} (CM)'
                          : '${userData.favoritePlane} (favorite plane)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    userData.userType == 'player'
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox(),
                    userData.userType == 'player'
                        ? Text(
                            '${userData.weight} (KG)',
                            style: const TextStyle(color: Colors.grey),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${userData.currentClube} (Current Clube)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${userData.location} (location)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Image.asset('assets/images/egypt.png')
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'About Player :',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              userData.about.toString(),
              style: const TextStyle(color: Colors.grey),
            ),
            userData.userType == 'player'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                          'Rate: ${userData.averageRating.toString().substring(0, 3)}'),
                      const SizedBox(width: 100),
                      const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
                      Text('Likes: ${userData.likeCounter}'),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  _buildMedia() {
    return Column(
      children: [
        ListTile(
          leading: const Text('Photos'),
          trailing: const Text('see More'),
          onTap: () {},
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('postTyp', isEqualTo: 'image')
              .where('ownerId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: 25.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((doc) {
                    final post =
                        PostModel.fromMap(doc.data() as Map<String, dynamic>);
                    return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            post.mediaUrl,
                            fit: BoxFit.fill,
                          ),
                        ));
                  }).toList(),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox(
              child: Text('this test'),
            );
          },
        ),
        ListTile(
          leading: const Text('Videos'),
          trailing: const Text('see More'),
          onTap: () {},
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('postTyp', isEqualTo: 'video')
              .where('ownerId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((doc) {
                    final post =
                        PostModel.fromMap(doc.data() as Map<String, dynamic>);
                    final flickManager = FlickManager(
                      videoPlayerController:
                          VideoPlayerController.network(post.mediaUrl),
                    );

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlickVideoPlayer(
                        flickManager: flickManager,
                      ),
                    );
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return const SizedBox(child: Text('unable to load video'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox(
              child: Text('this test'),
            );
          },
        )
      ],
    );
  }
}
