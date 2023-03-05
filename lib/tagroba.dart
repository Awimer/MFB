/*

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfb/activity/activity_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'on_boarding/on_boarding_screen.dart';

class Tagroba extends StatelessWidget {
  static const String routeName= 'tagroba';
  
  ActivityScreen? activityScreen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('MFB'),
        actions: [
          IconButton(
              onPressed: () async {
                // navigate directly to onboarding screen
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', false);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => OnBoardingScreen()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),),

          onPressed: () {
            showCountryPicker(
              context: context,
              //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
              exclude: <String>['KN', 'MF'],
              favorite: <String>['SE'],
              //Optional. Shows phone code before the country name.
              showPhoneCode: true,
              onSelect: (Country country) {
                print('Select country: ${country.displayName}');
              },
              // Optional. Sets the theme for the country list picker.
              countryListTheme: CountryListThemeData(
                // Optional. Sets the border radius for the bottomsheet.
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                // Optional. Styles the search field.
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Start typing to search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
                // Optional. Styles the text in the search field
                searchTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            );
          },
          child: const Text('Country',style: TextStyle(color: Colors.grey,),

          ),
        ),
      ),
    
    );
  }
}
*/

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Tagroba extends StatefulWidget {

  static const String routeName= 'tagroba';
  @override
  _TagrobaState createState() => _TagrobaState();
}

class ImageConfig {
  String source;
  String path;

  ImageConfig({required this.source, required this.path});
}

class _TagrobaState extends State<Tagroba> {

  final picker = ImagePicker();

  List<ImageConfig> imgList = [];

  List<Widget>? imageSliders;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imgList.add(ImageConfig(source: "file", path: pickedFile!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    imageSliders = imgList
        .map(
          (item) => Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  item.source == "http"
                      ? Image.network(item.path,
                      fit: BoxFit.cover, width: 1000.0)
                      : Image.file(File(item.path),
                      fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ],
              )),
        ),
      ),
    )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Any Thing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  pauseAutoPlayOnManualNavigate: true,
                  pauseAutoPlayOnTouch: true,
                  scrollDirection: Axis.horizontal),
              items: imageSliders,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}