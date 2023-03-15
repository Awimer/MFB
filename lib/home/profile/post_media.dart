import 'dart:io';

import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mfb/model/post_model.dart';
import 'package:mime/mime.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../core/components/action_button.dart';
import '../../dialoge_utils.dart';
import '../../model/player_model.dart';

enum MediaType { photo, video }

class PostMedia extends StatefulWidget {
  static const String routeName = 'postmedia';
  const PostMedia({super.key});

  @override
  State<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<PostMedia> {
  late VideoPlayerController _controller;
  final TextEditingController titlePost = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('post media'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel)),
          actions: [
            IconButton(onPressed: _post, icon: const Icon(Icons.check))
          ],
        ),
        floatingActionButton: AnimatedFloatingActionButton(
            //Fab list
            fabButtons: <Widget>[
              ActionButton(
                icon: const Icon(Icons.insert_photo),
                onPressed: () async {
                  await pickMedia();
                },
              ),
              ActionButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () {
                  pickMediaFromCamera(MediaType.photo);
                },
              ),
              /* ActionButton(
                icon: const Icon(Icons.videocam),
                onPressed: () {
                  pickMediaFromCamera(MediaType.video);
                },
              ) */
            ],
            key: widget.key,
            colorStartAnimation: Colors.blue,
            colorEndAnimation: Colors.red,
            animatedIconData: AnimatedIcons.menu_close //To principal button
            ),
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final user = PlayerModel.fromMap(
                    snapshot.data!.data() as Map<String, dynamic>);
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          leading: user.imageUrl.isEmpty
                              ? Image.asset('assets/images/player.png')
                              : Image.network(user.imageUrl),
                          title: Text(user.userName),
                          subtitle: Row(
                            children: [
                              DropdownButton<String>(
                                  hint: Row(
                                    children: [
                                      Icon(
                                        shareType == 'me'
                                            ? Icons.person
                                            : Icons.public,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(shareType),
                                    ],
                                  ),
                                  items: ['public', 'me']
                                      .map<DropdownMenuItem<String>>((title) {
                                    return DropdownMenuItem(
                                      value: title,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          title == 'me'
                                              ? const Icon(Icons.person)
                                              : const Icon(
                                                  Icons.public,
                                                  size: 18,
                                                ),
                                          const SizedBox(width: 2),
                                          Text(title),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: _onChange)
                            ],
                          ),
                        ),
                        TextField(
                          controller: titlePost,
                          maxLines: 6,
                          minLines: 1,
                          decoration:
                              const InputDecoration(hintText: 'Type something'),
                        ),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: 70.h,
                            child: file.path.isEmpty
                                ? const SizedBox()
                                : !isImage(file.path)
                                    ? InkWell(
                                        onTap: () {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        },
                                        child: VideoPlayer(_controller))
                                    : Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                        width: 10.w,
                                        height: 30.h,
                                      ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox();
            }));
  }

  bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('image/');
  }

  File file = File('');
  Future<void> pickMedia() async {
    FilePickerResult? result = await pickFile();
    if (result != null) {
      setState(() {
        file = File(result.paths.first!);
      });

      !isImage(file.path)
          ? _controller = VideoPlayerController.file(file)
          : print(file.path);

      if (!isImage(file.path)) {
        _controller.initialize().then((_) => setState(() {}));
      }
    } else {
      // User canceled the picker
    }
  }

  final ImagePicker _imagePicker = ImagePicker();
  void pickMediaFromCamera(type) {
    if (type == MediaType.photo) {
      pickPhotoFromCamera();
    } else {
      pickVideoFromCamera();
    }
  }

  void pickPhotoFromCamera() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    } else {
      // user cancel
    }
  }

  void pickVideoFromCamera() async {
    final XFile? video =
        await _imagePicker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      setState(() {
        file = File(video.path);
      });
    } else {
      // user cancel
    }
  }

  void crop(path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );

    if (isUserCancel(croppedFile)) {
    } else {
      setState(() {
        file = File(croppedFile!.path);
      });
    }
  }

  bool isUserCancel(CroppedFile? croppedFile) => croppedFile == null;

  pickFile() async {
    return await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'png',
          'jpeg',
          'jpg',
          'MP4',
          'MOV',
          'WMV',
          'FLV',
          'AVI',
          'MKV'
        ]);
  }

  void _post() async {
    String id = FirebaseFirestore.instance.collection('posts').doc().id;

    FirebaseFirestore.instance.collection('posts').doc(id).set(PostModel(
            id: id,
            postTyp: file.path.isNotEmpty
                ? !isImage(file.path)
                    ? 'video'
                    : 'image'
                : 'text',
            ownerId: FirebaseAuth.instance.currentUser!.uid,
            titlePost: titlePost.text,
            imageUrl: file.path.isEmpty ? '' : await uploadMedia(),
            shareType: shareType)
        .toMap());
  }

  String shareType = 'public';
  void _onChange(String? value) async {
    setState(() {
      shareType = value!;
    });
  }

  Future<String> uploadMedia() async {
    try {
      final snapshot = await FirebaseStorage.instance
          .ref(FirebaseAuth.instance.currentUser!.uid)
          .child('posts data')
          .child(file.path.split('/').last)
          .putFile(file);

      if (snapshot.state == TaskState.running) {
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                child: Column(
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 10),
                    Text('Please wait..')
                  ],
                ),
              );
            });
      } else if (snapshot.state == TaskState.success) {
        Navigator.pop(context);
      }
      return snapshot.ref.getDownloadURL();
    } on FirebaseException {
      return '';
    }
  }
}
