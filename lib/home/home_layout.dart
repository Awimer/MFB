import 'package:flutter/material.dart';
import 'package:mfb/home/profile.dart';
import 'package:mfb/home/settings/settings.dart';

import 'chat.dart';
import 'favorite.dart';
import 'home_screen.dart';


class HomeLayout extends StatefulWidget {
  static const String routeName = 'home layout';


  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget>screens=[
    HomeScreen(),
    FavouriteScreen(),
    ChatsScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:screens[currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 10),
          ],),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0,),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index){
              setState(() {
                currentIndex =index;
              });
            },
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            selectedIconTheme: IconThemeData(color: Colors.red),
            unselectedIconTheme: IconThemeData(color: Colors.black),
            selectedLabelStyle: TextStyle(color: Colors.red),
            unselectedLabelStyle: TextStyle(color: Colors.black),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled,),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  label: 'Favourites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wechat_sharp),
                  label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined),
                  label: 'Profile'
              ),
            ],
          ),
        ),
      ),
    );
  }
}