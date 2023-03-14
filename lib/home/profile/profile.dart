import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/core/components/action_button.dart';
import 'package:mfb/home/profile/post_media.dart';
import 'package:mfb/home/profile/profile_modify.dart';
import 'package:mfb/model/post_model.dart';
import 'package:sizer/sizer.dart';

import '../../model/player_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          key: key,
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
                      InkWell(
                        onTap: () {
                          final imageProvider =
                              Image.network(userData.imageUrl).image;
                          showImageViewer(context, imageProvider,
                              onViewerDismissed: () {});
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(
                              thickness: 1.5,
                              color: const Color.fromRGBO(253, 76, 114, 1)
                                  .withOpacity(.3),
                            ),
                            Image.asset(
                              'assets/images/circle_avater.png',
                            ),
                            userData.imageUrl == ''
                                ? const CircleAvatar(
                                    radius: 40,
                                    foregroundImage:
                                        AssetImage('assets/images/player.png'),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    foregroundImage:
                                        NetworkImage(userData.imageUrl),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildCardDetails(userData),
                      userData.userType == 'player'
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

  _buildCardDetails(userData) {
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
                Text(
                  '( ${userData.playerPosition!} )',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
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
                    Text(
                      '${userData.age} (year)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${userData.playerHeight} (CM)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${userData.weight} (KG)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${userData.location}',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text('Rate: ${userData.averageRating}'),
                const SizedBox(width: 100),
                const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
                Text('Likes: ${userData.likeCounter}'),
              ],
            ),
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
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('posts')
              .where('postTyp', isEqualTo: 'image')
              .where('ownerId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: 25.h,
                child: ListView(
                  children: snapshot.data!.docs.map((doc) {
                    final post =
                        PostModel.fromMap(doc.data() as Map<String, dynamic>);
                    return InkWell(
                        onTap: () {},
                        child: Image.network(
                          post.imageUrl,
                          fit: BoxFit.fill,
                        ));
                  }).toList(),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox();
          },
        ),
        ListTile(
          leading: const Text('Videos'),
          trailing: const Text('see More'),
          onTap: () {},
        ),
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('posts')
              .where('postType', isEqualTo: 'video')
              .where('ownerId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: 25.h,
                child: ListView(
                  children: snapshot.data!.docs.map((doc) {
                    final post =
                        PostModel.fromMap(doc.data() as Map<String, dynamic>);
                    return Image.network(post.imageUrl);
                  }).toList(),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
