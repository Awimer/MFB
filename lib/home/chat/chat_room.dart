import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/message_model.dart';
import '../../model/my_user.dart';

class ChatRoom extends StatefulWidget {
  static const String routeName = 'chatRoom';

  ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController message = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  void onSendMessage(chatRoomId) async {
    if (message.text.trim().isNotEmpty) {
      final messages = MessageModel(
        message: message.text,
        sendby: auth.currentUser!.uid,
        type: 'text',
        time: DateTime.now().toString(),
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
    final chatRoomId = ModalRoute.of(context)!.settings.arguments as String;

    print(chatRoomId.split('&').last);
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(chatRoomId.split('&').last)
            .get(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final userData =
                MyUser.fromMap(snapshot.data!.data() as Map<String, dynamic>);
            return Scaffold(
              //resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    userData.imageUrl!.isEmpty
                        ? Image.asset(
                            'assets/images/player.png',
                            width: 30,
                            height: 30,
                          )
                        : Image.network(
                            userData.imageUrl.toString(),
                            width: 30,
                            height: 30,
                          ),
                    Text(userData.userName),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('chatroom')
                        .doc(chatRoomId)
                        .collection('chats')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Expanded(
                          child: ListView(
                            reverse: true,
                            children: snapshot.data!.docs.map((doc) {
                              final message = MessageModel.fromMap(
                                  doc.data() as Map<String, dynamic>);
                              return messageWidgetUi(size, message);
                            }).toList(),
                          ),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: message,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.photo),
                              ),
                              hintText: "Send Message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () => onSendMessage(chatRoomId)),
                    ],
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }

  Widget messageWidgetUi(Size size, MessageModel messageModel) {
    return Container(
      width: size.width,
      alignment: messageModel.sendby == auth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: messageModel.sendby == auth.currentUser!.uid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: messageModel.sendby == auth.currentUser!.uid
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              DateFormat('hh:mm a')
                  .format(DateTime.parse(messageModel.time))
                  .toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
