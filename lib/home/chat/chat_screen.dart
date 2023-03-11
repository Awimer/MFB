import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/message_model.dart';
import '../../model/my_user.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('conversetions')
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final chatRoom = ChatModel.fromMap(
                  doc.data() as Map<String, dynamic>);
              return Column(
                children: [
                  ListTile(
                    leading: chatRoom.imageUrl.isEmpty
                        ? const CircleAvatar(
                            radius: 40,
                            foregroundImage:
                                AssetImage('assets/images/player.png'),
                          )
                        : CircleAvatar(
                            radius: 40,
                            foregroundImage: NetworkImage(chatRoom.imageUrl),
                          ),
                    title: Text(chatRoom.userName),
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
    ));
  }
}
