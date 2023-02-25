import 'package:flutter/material.dart';
import 'package:mfb/home/chat/chat_room.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(child:
    Text('Favourites Players',
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    );
  }
}