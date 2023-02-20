import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  static const String routeName = 'forget';

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  bool securedPassword = true;

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text('Forget Password',
          style: TextStyle(
            color: Colors.black,

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/forget_password.png'),
                SizedBox(height: 30,),
                Text('Forget Password?',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(height: 8,),
                Text('Enter your email to reset the Password',
                  style: TextStyle(
                      fontSize:18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 20,),

                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    hintText: 'E-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red,)
                    ),
                  ),),
                SizedBox(height: 20,),
                MaterialButton(onPressed: (){
                },
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: double.infinity,
                  child: Text('Send Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  color: Colors.redAccent.shade700,
                  height: 50,

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}