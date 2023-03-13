import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/chat/chat_room.dart';

import '../../model/message_model.dart';
import '../../model/my_user.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: const Color(0xffE20030),
          title: const Text(
            'Message',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 21),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffFD4C72),
                ),
                width: 40,
                child: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, right: 20, left: 4),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffFD4C72),
                ),
                width: 40,
                child: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top:16),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('conversetions')
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    final chatRoom =
                        ChatModel.fromMap(doc.data() as Map<String, dynamic>);
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, ChatRoom.routeName,
                                arguments: chatRoom.senderId);
                          },
                          leading: chatRoom.imageUrl.isEmpty
                              ? const CircleAvatar(
                                  radius: 40,
                                  foregroundImage:
                                      AssetImage('assets/images/player.png'),
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  foregroundImage:
                                      NetworkImage(chatRoom.imageUrl),
                                ),
                          title: Text(
                            chatRoom.userName,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          subtitle: Text(chatRoom.message),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
