import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../model/post_model.dart';

class RealPage extends StatefulWidget {
  static const String routeName = 'rals';
  const RealPage({super.key});

  @override
  State<RealPage> createState() => _RealPageState();
}

class _RealPageState extends State<RealPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = List.from(snapshot.data!.docs.map(
                  (e) => PostModel.fromMap(e.data() as Map<String, dynamic>)));
              return PageView(
                scrollDirection: Axis.vertical,
                children: posts.map((e) => ContentPage(post: e)).toList(),
              );
            }
            return const SizedBox();
          }),
    );
  }
}

class ContentPage extends StatefulWidget {
  final PostModel post;
  const ContentPage({super.key, required this.post});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  // ignore: non_constant_identifier_names
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.post.mediaUrl)
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.play();
    return Stack(
      children: [
        Expanded(
          child: controller.value.isInitialized
              ? VideoPlayer(controller)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        )
      ],
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
