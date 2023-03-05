import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfb/data_base/my_database.dart';
import 'package:mfb/model/my_user.dart';

import '../../model/message_model.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController message = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (message.text.trim().isNotEmpty) {
      final messages = MessageModel(
        message: message.text,
        sendby: auth.currentUser!.email!,
        type: 'text',
        time: FieldValue.serverTimestamp().toString(),
      );

      message.clear();
      await firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages.toMap());
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
            SizedBox(
              height: size.height / 1.3,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.map((doc) {
                        final message = MessageModel.fromMap(
                            doc.data() as Map<String, dynamic>);
                        return messageWidgetUi(size, message);
                      }).toList(),
                    );
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
                              onPressed: () {},
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
        ));
  }

  Widget messageWidgetUi(Size size, MessageModel messageModel) {
    return Container(
      width: size.width,
      alignment: messageModel.sendby == auth.currentUser!.email
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: messageModel.sendby == auth.currentUser!.email
                ? Colors.blue
                : Colors.red),
        child: Text(
          messageModel.message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
