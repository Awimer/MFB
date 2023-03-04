import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/home_screen/popular_player_item.dart';
import 'package:mfb/home/home_screen/searchScreen.dart';
import 'package:mfb/model/my_user.dart';

import '../../data_base/my_database.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final collectionStream = FirebaseFirestore.instance
      .collection(MyUser.collectionName)
      .snapshots();

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
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleSpacing: 20,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/image_profile.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //firestore.collection('users').doc('userName'),
                    //display = auth.currentUser.displayName;
                    //snapshot.data!.docs[index]['userName'].toString();
                    Text(
                      data['userName'],
                      //'hi ${auth.currentUser!.email!}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons
                        .notifications_none_outlined), /* color: Theme.of(context).canvasColor,*/
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Search',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Icon(
                              Icons.tune_outlined,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 100.0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 20.0,
                        ),
                        itemCount: 5,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Popular Players',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'See All',
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child:
                            ListView.separated(
                                //shrinkWrap: true,
                                //physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return PopularPlayerItem();
                                  },
                                separatorBuilder: (context, index) => const SizedBox(
                                      height: 15,
                                    ),
                                itemCount: data.length),
                            /*StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection('users')
                                  .snapshots(),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.data != null) {

                                  return ListView.separated(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data = snapshot.data!
                                          .docs[index]
                                          .data() as Map<String, dynamic>;
                                      return PopularPlayerItem();
                                    },
                                    separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  );
                                }
                                    else {
                                  return Container();
                                }
                              },
                            ),*/
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget buildCategoryItem() => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Material(elevation: 10.0, color: Colors.grey),
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
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                  child: Text(
                'Goal Keeper',
                style: Theme.of(context).textTheme.bodyText2,
              )),
            ),
          ],
        ),
      );

  /*Widget buildPopularPlayerItem() => Container(
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
                    Text('Ahmed Shadi'),
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
      );*/
}