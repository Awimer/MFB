import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'activity/activity_screen.dart';

class Tagrobaa extends StatelessWidget {
  static const String routeName= 'tagrobaa';
  ActivityScreen? activityScreen;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        activityScreen?.selectedButton==1
      ? Text('1')
            : Text('2')
    ],
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import '../../model/message_model.dart';
//
// class ChatRoom extends StatelessWidget {
//   final Map<String, dynamic> userMap;
//   final String chatRoomId;
//
//   ChatRoom({required this.chatRoomId, required this.userMap});
//
//   final TextEditingController message = TextEditingController();
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   void onSendMessage() async {
//     if (message.text.trim().isNotEmpty) {
//       final messages = MessageModel(
//         message: message.text,
//         sendby: auth.currentUser!.email!,
//         type: 'text',
//         time: FieldValue.serverTimestamp().toString(),
//       );
//
//       message.clear();
//       await firestore
//           .collection('chatroom')
//           .doc(chatRoomId)
//           .collection('chats')
//           .add(messages.toMap());
//     } else {
//       print("Enter Some Text");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//         appBar: (AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/image_profile.png'),
//               ),
//               SizedBox(width: 12,),
//               Text(userMap['userName'],
//                 style: TextStyle(color: Color(0xff555555),
//                     fontSize: 18,
//                     fontWeight: FontWeight.w400
//                 ),),
//             ],
//           ),
//           leading: const BackButton(
//             color: Colors.red,
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Color(0xffFD4C72),
//                 ),
//                 width : 40,
//                 child: const Icon(Icons.phone_in_talk_outlined,color: Colors.white,),),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8,bottom: 8,right: 20,left: 4),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Color(0xffFD4C72),
//                 ),
//                 width : 40,
//                 child: const Icon(Icons.videocam_outlined,color: Colors.white,),),
//             ),
//           ],
//         )),
//         body: SingleChildScrollView(
//           child: Column(children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Divider(
//                 thickness: 1,
//                 color: Color(0xffD5D5D5),
//                 height: 36,),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: SizedBox(
//                 height: size.height / 1.4,
//                 width: size.width,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: firestore
//                       .collection('chatroom')
//                       .doc(chatRoomId)
//                       .collection('chats')
//                       .snapshots(),
//                   builder: ( context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else {
//                       return ListView(
//                         children: snapshot.data!.docs.map((doc) {
//                           final message = MessageModel.fromMap(
//                               doc.data() as Map<String, dynamic>);
//                           return messageWidgetUi(size, message);
//                         }).toList(),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ),
//             Container(
//               height: size.height / 17,
//               width: size.width,
//               alignment: Alignment.center,
//               child: Container(
//                 height: size.height / 12,
//                 width: size.width / 1.1,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: size.height / 17,
//                       width: size.width / 1.3,
//                       child: TextField(
//                         controller: message,
//                         decoration: InputDecoration(
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey,)
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: () {},
//                               icon: Icon(Icons.photo,color: Colors.black.withOpacity(0.2),),
//                             ),
//                             hintText: "Type Message",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             )),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: const Color(0xffFD4C72),
//                         ),
//                         width : 40,
//                         height: 40,
//                         child:  IconButton(onPressed: onSendMessage,
//                           icon: const Icon(Icons.send,color: Colors.white,),),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ]),
//         ));
//   }
//
//   Widget messageWidgetUi(Size size, MessageModel messageModel) {
//     return Container(
//         width: size.width,
//         alignment: messageModel.sendby == auth.currentUser!.email
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//             margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: messageModel.sendby == auth.currentUser!.email
//                     ? const Color(0xffF7A2B5).withOpacity(0.5)
//                     : const Color(0xffF4F6F9)),
//             child: Text(
//               messageModel.message,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             ),
//         );
//     }