import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/my_user.dart';

class PopularPlayerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(child: Text('There is an error'));
          } else if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                final user = MyUser.fromMap(doc.data() as Map<String, dynamic>);
                return Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.userName),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            '22 Years old',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Striker',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                                size: 21,
                              ),
                              const Expanded(
                                child: Text(
                                  'Cairo,Egypt',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
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
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}


/* 
Container(
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
                ), */

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
