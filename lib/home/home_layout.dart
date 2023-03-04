import 'package:flutter/material.dart';
import 'package:mfb/home/profile/profile.dart';
import 'package:mfb/home/settings/settings.dart';

import 'chat/chat_screen.dart';
import 'favorite.dart';
import 'home_screen/home_screen.dart';


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
    ChatScreen(),
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
            selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            selectedIconTheme: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
            unselectedIconTheme: Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
            selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            unselectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                  icon: Icon(Icons.home_filled,),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,

                  icon: Icon(Icons.favorite_border_outlined),
                  label: 'Favourites'
              ),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,

                  icon: Icon(Icons.wechat_sharp),
                  label: 'Chats'
              ),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,

                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,

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