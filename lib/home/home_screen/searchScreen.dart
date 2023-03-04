import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/chat/chat_room.dart';

import '../../model/my_user.dart';


class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, dynamic>? userMap;
  final searchController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text('Search Screen'),
        centerTitle: true,
      ),
      body:
      isLoading
          ? Center(
              child: Container(
                child: Text('Not Found',style: (TextStyle(
                  fontSize: 32
                )),),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 14,
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                      validator:(text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return 'please enter user name';
                        }
                      },
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'user name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                ElevatedButton(
                  onPressed: () {

                    onSearch();

                  },
                  child: Text('Search'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/30,),
                userMap != null
                    ? ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              auth.currentUser!.email!,
                              userMap!['userName']);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                              ChatRoom(chatRoomId: roomId, userMap: userMap!)
                          ));
                        },
                        leading: Icon(
                          Icons.account_box,
                          color: Colors.black,
                        ),
                        title: Text(userMap!['userName']),
                        trailing: Icon(
                          Icons.chat,
                          color: Colors.black,
                        ),
                      )
                    : Container(),
              ],
            ),
    );
  }

  void onSearch() async {
    if(formKey.currentState?.validate()== false){
      return;
  }
    setState(() {
      isLoading = true;
    });

    await firestore
        .collection('users')
        .where('userName', isEqualTo: searchController.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

}
