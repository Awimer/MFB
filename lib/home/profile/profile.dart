import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/profile/profile_modify.dart';
import 'package:mfb/player%20details/player_details.dart';

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
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final userData =
                  MyUser.fromMap(snapshot.data!.data() as Map<String, dynamic>);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                          color: const Color.fromRGBO(253, 76, 114, 1)
                              .withOpacity(.3),
                        )),
                        Stack(
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
                                  )
                          ],
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            color: const Color.fromRGBO(253, 76, 114, 1)
                                .withOpacity(.3),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            userData.userName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userData.email,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ProfileModify.routeName);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(238, 190, 187, 1.0),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.edit_outlined,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'Edit Availavility',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 44,
                        width: 340,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${userData.age}  (year)',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(253, 76, 114, 1),
                                      )),
                                  Text('${userData.playerHeight} (CM)',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(253, 76, 114, 1),
                                      )),
                                  Text('${userData.weight} (KG)',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(253, 76, 114, 1),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 51,
                              width: 340,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(247, 247, 247, 1)),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone_iphone_outlined,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    userData.phone,
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              'Location',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 51,
                              width: 340,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(247, 247, 247, 1)),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    userData.location.toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            const Text(
                              'Position',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 51,
                                  width: 109,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(247, 247, 247, 1)),
                                  child: Row(
                                    children: const [
                                      CircleAvatar(
                                        minRadius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          'P',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Striker',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 51,
                                  width: 109,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(247, 247, 247, 1)),
                                  child: Row(
                                    children: const [
                                      CircleAvatar(
                                        minRadius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          'S',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Center',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 51,
                                  width: 109,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(247, 247, 247, 1)),
                                  child: Row(
                                    children: const [
                                      CircleAvatar(
                                        minRadius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          'T',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Center',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
