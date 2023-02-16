import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfb/login_screen.dart';

class AciviyScreen extends StatelessWidget {
  static const String routeName ='activity';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Container(
            height: MediaQuery.of(context).size.height*0.1,
                child: Image.asset('assets/images/logo.png',
                  fit: BoxFit.cover,
                ),

          ),
          SizedBox(height: 32,),
          Container(
            height: MediaQuery.of(context).size.height*0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: Image.asset('assets/images/activiy.png',
                        //fit: BoxFit.cover,
                      ),
                    ),
                    Text('What is your Activity ?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),),
                  ],
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: MediaQuery.of(context).size.height*0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen()));
                  }, child: Text('Player',
                    style: TextStyle(fontSize: 16,color: Colors.red),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(color: Colors.red),
                      minimumSize: Size(10,50),
                    ),
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(onPressed: (){}, child: Text('Coach',
                    style: TextStyle(fontSize: 16,color: Colors.red),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(color: Colors.red),
                      minimumSize: Size(10,50),
                    ),
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(onPressed: (){}, child: Text('Fan',
                    style: TextStyle(fontSize: 16,color: Colors.red),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(color: Colors.red),
                      minimumSize: Size(10,50),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.05,)
        ],
      ),
    );
  }
}
