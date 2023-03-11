import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/my_user.dart';

class ProfileModify extends StatefulWidget {
  static const String routeName = 'profileModify';
  const ProfileModify({super.key});

  @override
  State<ProfileModify> createState() => _ProfileModifyState();
}

class _ProfileModifyState extends State<ProfileModify> {
  final userNameController = TextEditingController();
  final ageController = TextEditingController();
  final playerHeightController = TextEditingController();
  final playerPositionController = TextEditingController();
  final locationController = TextEditingController();
  final weightController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final aboutController = TextEditingController();

  final List<String> positionList = [
    'Gk',
    'CB',
    'RB',
    'LB',
    'CDM',
    'CM',
    'CAM',
    'RW',
    'LW',
    'ST',
  ];

  String selectedPlayerPosition = '';

  final space = const SizedBox(height: 10);
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Modify'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData =
                MyUser.fromMap(snapshot.data!.data() as Map<String, dynamic>);
            downloadUrl = userData.imageUrl!;
            return SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(
                          thickness: 1.5,
                          color: const Color.fromRGBO(253, 76, 114, 1)
                              .withOpacity(.3),
                        ),
                        Image.asset(
                          'assets/images/circle_avater.png',
                        ),
                        userData.imageUrl == ''
                            ? imagePath == ''
                                ? const CircleAvatar(
                                    radius: 40,
                                    foregroundImage:
                                        AssetImage('assets/images/player.png'),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    foregroundImage:
                                        FileImage(File(photo!.path)),
                                  )
                            : CircleAvatar(
                                radius: 40,
                                foregroundImage:
                                    NetworkImage(userData.imageUrl!),
                              ),
                        Positioned(
                          top: 50,
                          left: 210,
                          child: IconButton(
                            onPressed: _selecteImage,
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _customTextField(
                      'user Name',
                      TextInputType.name,
                      userData.userName,
                      userNameController,
                      const Icon(Icons.person_pin_sharp),
                    ),
                    space,
                    _customTextField(
                      'Age',
                      TextInputType.number,
                      userData.age,
                      ageController,
                      const Icon(Icons.person),
                    ),
                    space,
                    _customTextField(
                      'Height',
                      TextInputType.number,
                      userData.playerHeight,
                      playerHeightController,
                      const Icon(Icons.height),
                    ),
                    space,
                    _customTextField(
                      'Weight',
                      TextInputType.number,
                      userData.weight,
                      weightController,
                      const Icon(Icons.line_weight),
                    ),
                    space,
                    _customTextField(
                      'About',
                      TextInputType.text,
                      userData.about,
                      aboutController,
                      const Icon(Icons.info),
                    ),
                    space,
                    _customTextField(
                      'Player Position',
                      TextInputType.text,
                      selectedPlayerPosition,
                      playerPositionController,
                      DropdownButton<String>(
                          hint: const Icon(Icons.location_pin),
                          items: positionList
                              .map<DropdownMenuItem<String>>((playerPosition) {
                            return DropdownMenuItem(
                              value: playerPosition,
                              child: Text(playerPosition),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPlayerPosition = value!;
                            });
                          }),
                    ),
                    space,
                    _customTextField(
                      'Location',
                      TextInputType.streetAddress,
                      userData.location.toString().isEmpty
                          ? ''
                          : userData.location.toString(),
                      locationController,
                      const Icon(Icons.location_city),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: _updateProfile,
                        child: const Text('Update Profile'))
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }

  Widget _customTextField(
    title,
    textType, [
    initValue,
    controller,
    widget,
  ]) {
    //controller.text = '$initValue';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        readOnly: title == 'Player Position',
        controller: controller,
        keyboardType: textType,
        validator: (text) {
          if (title != 'Player Position' && text!.isEmpty) {
            return 'this Field required';
          }
          if (title == 'userName' && text!.length < 3) {
            return 'User Name must be more than 2 char';
          }
          return null;
        },
        minLines: title == 'About' ? 4 : 1,
        maxLines: title == 'About' ? 4 : 1,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: widget,
          ),
          hintText: title == 'Player Position' ? selectedPlayerPosition : title,
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  final ImagePicker _imagePicker = ImagePicker();

  XFile? photo;

  String imagePath = '';
  Future<void> _selecteImage() async {
    photo = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      setState(() {
        imagePath = photo!.path;
      });
    } else {
      //user cancel
    }
  }

  String downloadUrl = '';
  void _updateProfile() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    if (imagePath.isNotEmpty) {
      downloadUrl = await _uploadImage();
    }
    Map<String, dynamic> userData = {
      'age': ageController.text,
      'playerHeight': playerHeightController.text,
      'playerPosition': selectedPlayerPosition,
      'weight': weightController.text,
      'location': locationController.text,
      'userName': userNameController.text,
      'imageUrl': downloadUrl,
      'about': aboutController.text
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userData)
        .then((value) {});
  }

  Future<String> _uploadImage() async {
    try {
      final snapshot = await FirebaseStorage.instance
          .ref('Player photo')
          .child(photo!.name)
          .putFile(File(imagePath));
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }
}
