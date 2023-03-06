import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mfb/model/my_user.dart';

class PlayerDetails extends StatefulWidget {
  static const String routeName = 'player details';
  const PlayerDetails({super.key});

  @override
  State<PlayerDetails> createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  String userId = '';

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(226, 0, 48, 1),
        title: const Text(
          'Player Deatails',
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(226, 0, 48, 1),
        child: const Icon(Icons.chat_bubble_outline),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
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
                      Image.network(userData.imageUrl!),
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
/*   Widget buildPhotoItem() => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            const Material(elevation: 10.0, color: Colors.grey),
            Image.asset(
              'assets/image/Rectangle.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
  Widget buildVidioItem() => Image.asset('assets/image/vid.png');
}

 */
/* 
 Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Photos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildPhotoItem(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20.0,
                  ),
                  itemCount: 5,
                ),
              ),
              Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Vedios',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildVidioItem(),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                  itemCount: 10),
                   */