import 'package:flutter/material.dart';

class CreatePassword extends StatelessWidget {
  static const String routeName = 'create password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:Text('Create Password',
          style: TextStyle(
              color: Colors.black
          ),
        ) ,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/password.png'),
              Text('Create New Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              SizedBox(height: 15,),
              Text('Create Strong Password To Protect it from hacking',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 30.0,),
              TextFormField(

                decoration: InputDecoration(
                  hintText: 'User Name',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red,)
                  ),
                ),),
              SizedBox(height: 30.0,),
              MaterialButton(onPressed: (){},
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.red)
                ),
                minWidth: double.infinity,
                child: Text('Create Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: Colors.red,
                height: 50,

              ),
            ],
          ),
        ),
      ),
    );
  }
}