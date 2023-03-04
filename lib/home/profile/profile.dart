/*
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String profilePicLink = "";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref =
        FirebaseStorage.instance.ref().child('assets/images/player.png');

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickUploadProfilePic();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 80, bottom: 24),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: profilePicLink == " "
                      ? const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(profilePicLink),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(226, 0, 48, 1),
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                      children: [
                        Expanded(
                            child: new Container(
                              child: Divider(
                                thickness: 1.5,
                                color: Color.fromRGBO(253, 76, 114, 1).withOpacity(.3),
                              ),
                            )),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/images/circle avater.png'),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/player.png'),
                                    fit: BoxFit.fill),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: new Container(
                            child: Divider(
                              thickness: 1.5,
                              color: Color.fromRGBO(253, 76, 114, 1).withOpacity(.3),
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Text('Ahmed shadi',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Ahmedshadi@gmail.com',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(onPressed: (){},
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                            Color.fromRGBO(238, 190, 187, 1.0),
                          ),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit_outlined,color: Colors.black,),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                'Edit Availavility',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    height: 44,
                    width: 340,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('22 Years',
                                    style: TextStyle(
                                      color: Color.fromRGBO(253, 76, 114, 1),
                                    )
                                ),
                              ),
                              Expanded(
                                child: Text('178 (CM)',
                                    style: TextStyle(
                                      color: Color.fromRGBO(253, 76, 114, 1),
                                    )
                                ),
                              ),
                              Expanded(
                                child: Text('65 (KG)',
                                    style: TextStyle(
                                      color: Color.fromRGBO(253, 76, 114, 1),
                                    )
                                ),
                              ),
                              Expanded(
                                child: Text('Right Leg',
                                    style: TextStyle(
                                      color: Color.fromRGBO(253, 76, 114, 1),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone Number',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 51,
                          width: 340,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 247, 247, 1)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.phone_iphone_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 20,),
                              Text('+201150632022',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 28,),
                        Text('Location',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 51,
                          width: 340,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 247, 247, 1)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 20,),
                              Text('Cairo,Egypt',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 28,),
                        Text('Position',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 51,
                              width: 109,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(247, 247, 247, 1)
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    minRadius: 10,
                                    backgroundColor: Colors.red,
                                    child: Text('P',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Text('Striker',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 51,
                              width: 109,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(247, 247, 247, 1)
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    minRadius: 10,
                                    backgroundColor: Colors.red,
                                    child: Text('S',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Text('Center',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 51,
                              width: 109,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(247, 247, 247, 1)
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    minRadius: 10,
                                    backgroundColor: Colors.red,
                                    child: Text('T',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Text('Center',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              ),
        ),
        );
    }
}