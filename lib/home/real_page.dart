import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mfb/model/player_model.dart';
import 'package:video_player/video_player.dart';

import '../model/post_model.dart';
import '../player details/player_details.dart';

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
  late FlickManager flick;

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.post.mediaUrl)
      ..initialize().then((value) {
        flick = FlickManager(
          autoPlay: false,
          videoPlayerController: VideoPlayerController.network(
            widget.post.mediaUrl,
          ),
        );
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    flick.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.post.ownerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = PlayerModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return Stack(
              children: [
                controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 5 / 10,
                        child: FlickVideoPlayer(flickManager: flick))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PlayerDetails.routeName,
                                arguments: user.id);
                          },
                          child: user.imageUrl == ''
                              ? Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/circle_avater.png'),
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 30,
                                    foregroundImage:
                                        AssetImage('assets/images/player.png'),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/circle_avater.png'),
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    foregroundImage:
                                        NetworkImage(user.imageUrl),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 10),
                        FavoriteButton(
                          iconSize: 70,
                          isFavorite: user.isLiked,
                          valueChanged: (isLiked) {
                            if (isLiked) {}
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      user.userName,
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
