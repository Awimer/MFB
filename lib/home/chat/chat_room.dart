import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/message_model.dart';
import '../../model/my_user.dart';

class ChatRoom extends StatefulWidget {
  static const String routeName = 'chatRoom';

  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController message = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String currentChatRoomId = '';

  String createChatRoomId(receiverId, sender) {
    if (receiverId.toLowerCase().codeUnits[0] <
        sender.toLowerCase().codeUnits[0]) {
      return '$receiverId$sender';
    } else {
      return '$sender$receiverId';
    }
  }

  void onSendMessage(userData) async {
    if (message.text.trim().isNotEmpty) {
      final messageId = firestore
          .collection('chatroom')
          .doc(currentChatRoomId)
          .collection('messages')
          .doc()
          .id;

      final messageModel = MessageModel(
        id: messageId,
        message: message.text,
        sender: auth.currentUser!.uid,
        receiver: userData.id,
        type: 'text',
        time: FieldValue.serverTimestamp(),
      );

      final chatRoom = ChatRoomModel(
        chatRoomId: currentChatRoomId,
        users: [userData.id, auth.currentUser!.uid],
      );

      firestore
          .collection('chatroom')
          .doc(currentChatRoomId)
          .set(chatRoom.toMap());

      firestore
          .collection('chatroom')
          .doc(currentChatRoomId)
          .collection('messages')
          .doc(messageId)
          .set(messageModel.toMap());

      firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('conversetions')
            .doc(currentChatRoomId)
            .set(ChatModel(
                    chatRoomId: currentChatRoomId,
                    message: messageModel.message,
                    lastMessageId: messageId,
                    senderId: auth.currentUser!.uid,
                    imageUrl: userData.imageUrl,
                    userName: userData.userName)
                .toMap());

        firestore
            .collection('users')
            .doc(userData.id)
            .collection('conversetions')
            .doc(currentChatRoomId)
            .set(ChatModel(
                    chatRoomId: currentChatRoomId,
                    message: messageModel.message,
                    lastMessageId: messageId,
                    senderId: auth.currentUser!.uid,
                    imageUrl: value.data()!['imageUrl'],
                    userName: value.data()!['userName'])
                .toMap());
      });

      message.clear();
    } else {
    }
  }

  bool chatRoomExists(ChatRoomModel chatModel, userData) =>
      chatModel.users.contains(userData.id) &&
      chatModel.users.contains(auth.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final receiverId = ModalRoute.of(context)!.settings.arguments as String;
    currentChatRoomId =
        createChatRoomId(receiverId, FirebaseAuth.instance.currentUser!.uid);

    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(receiverId)
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
                        .doc(currentChatRoomId)
                        .collection('messages')
                        .orderBy('time')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Expanded(
                          child: ListView(
                            reverse: true,
                            children: snapshot.data!.docs.reversed.map((doc) {
                              final chatRoomMessage = MessageModel.fromMap(
                                  doc.data() as Map<String, dynamic>);

                              if (chatRoomMessage.sender == userData.id ||
                                  chatRoomMessage.receiver == userData.id &&
                                      chatRoomMessage.sender ==
                                          auth.currentUser!.uid ||
                                  chatRoomMessage.receiver ==
                                      auth.currentUser!.uid) {
                                return messageWidgetUi(size, chatRoomMessage);
                              }
                              return const SizedBox();
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
                          onPressed: () => onSendMessage(userData)),
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
      alignment: messageModel.sender == auth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: messageModel.sender == auth.currentUser!.uid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: messageModel.sender == auth.currentUser!.uid
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
        ],
      ),
    );
  }
}
