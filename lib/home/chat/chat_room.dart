
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;


  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController message = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;




  void onSendMessage() async {
    if (message.text.trim().isNotEmpty ) {
      Map<String, dynamic> messages = {
        "sendby": auth.currentUser!.email,
        "message": message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      message.clear();
      await firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: (AppBar(
        title: Text(userMap['userName']),
      )),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: size.height / 1.3,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      return messages(size, map);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        Container(
            height: size.height / 17,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 12,
              width: size.width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height / 17,
                    width: size.width / 1.3,
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.photo),
                          ),
                          hintText: "Send Message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.send), onPressed: onSendMessage),
                ],
              ),
            ),
        )
        ]),

    )
    );
  }

  Widget? messages(Size size, Map<String, dynamic> map) {
    Container(
      width: size.width,
      alignment: map['sendby'] == auth.currentUser!.email
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sendby'] == auth.currentUser!.email
          ? Colors.blue
              :Colors.red
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
