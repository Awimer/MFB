import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/my_user.dart';

class PopularPlayerItem extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<DocumentSnapshot>(
        future: usersCollection.doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SizedBox(child: Text('There is an error'));
          }
            if (snapshot.hasData) {
              final data = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme
                        .of(context)
                        .cardColor),
                child: Row(
                  children: [
                    Image.asset('assets/images/player.png'),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['userName']),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '22 Years old',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Striker',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                  size: 21,
                                ),
                                Expanded(
                                  child: Text(
                                    'Cairo,Egypt',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: IconButton(onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_outline_sharp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

          return Center(child: CircularProgressIndicator());
        });
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularPlayerItem extends StatelessWidget {
  const PopularPlayerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor),
      child: Row(
        children: [
          Image.asset('assets/images/player.png'),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['userName']),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '22 Years old',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Striker',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 21,
                      ),
                      Expanded(
                        child: Text(
                          'Cairo,Egypt',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.favorite_outline_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/
