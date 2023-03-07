import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/profile/profile_modify.dart';
import 'package:mfb/login/login_screen.dart';

import '../../model/my_user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(226, 0, 48, 1),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ProfileModify.routeName);
        },
        backgroundColor: const Color.fromRGBO(226, 0, 48, 1),
        child: const Icon(Icons.edit),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final userData =
                  MyUser.fromMap(snapshot.data!.data() as Map<String, dynamic>);
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          final imageProvider =
                              Image.network(userData.imageUrl!).image;
                          showImageViewer(context, imageProvider,
                              onViewerDismissed: () {});
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: const Color.fromRGBO(253, 76, 114, 1)
                                    .withOpacity(.3),
                              ),
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
                                        NetworkImage(userData.imageUrl!),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${userData.age} (year)',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${userData.playerHeight} (CM)',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${userData.weight} (KG)',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        userData.phone,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${userData.location}',
                                        style:
                                            const TextStyle(color: Colors.grey),
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
                      ),
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
}
