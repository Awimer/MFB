import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  static const String routeName = 'forget';

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  final emailController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text('Forget Password',
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
                const SizedBox(height: 30,),
                const Text('Forget Password?',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(height: 8,),
                const Text('Enter your email to reset the Password',
                  style: TextStyle(
                      fontSize:18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                  ),
                ),
                const SizedBox(height: 20,),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    hintText: 'E-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red,)
                    ),
                  ),),
                const SizedBox(height: 20,),
                MaterialButton(onPressed: (){
                  resetPassword();
                },
                  shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: double.infinity,
                  color: Colors.redAccent.shade700,
                  height: 50,
                  child: const Text('Send Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    const CircleAvatar(
      child: CircularProgressIndicator(),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password Reset Email Sent")));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.message}")));
      Navigator.of(context).pop();
    }
  }

}