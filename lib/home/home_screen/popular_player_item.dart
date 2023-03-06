import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/my_user.dart';

class PopularPlayerItem extends StatelessWidget {
  const PopularPlayerItem({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 7);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(child: Text('There is an error'));
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView(
                children: snapshot.data!.docs.map((doc) {
                  final user =
                      MyUser.fromMap(doc.data() as Map<String, dynamic>);
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).cardColor),
                    child: Row(
                      children: [
                        Image.asset('assets/images/player.png'),
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
                            const Text(
                              '22 Years old',
                              style: TextStyle(color: Colors.grey),
                            ),
                            space,
                            const Text(
                              'Striker',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                  size: 21,
                                ),
                                const Text(
                                  'Cairo,Egypt',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_outline_sharp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
