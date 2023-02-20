import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfb/register_login/register_screen.dart';
import 'package:mfb/register_login/validation_utils.dart';

import '../dialoge_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool securedPassword = true;

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  Text('Login',
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    controller: emailController,
                    validator:(text){
                      if (text == null || text.trim().isEmpty){
                        return 'please enter Email';
                      }
                      if(!ValidationUtils.isValidEmail(text)){
                        return 'please enter a valid Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),

                  ),
                  SizedBox(height: 20.0,),

                  TextFormField(
                    controller: passwordController,
                    validator:(text){
                      if (text == null || text.trim().isEmpty){
                        return 'please enter password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: InkWell(
                        onTap: (){
                          securedPassword =!securedPassword;
                          setState(() {

                          });
                        },
                        child: Icon(
                          securedPassword ?
                          Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){}, child: Text('Forget Password',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )),
                    ],
                  ),
                  MaterialButton(onPressed: (){
                    createAccountClicked();
                  },
                    minWidth: double.infinity,
                    child: Text('Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    color: Colors.red,
                    height: 50,

                  ),
                  Row(
                    children: [
                      Text('Dont have an account?'),
                      TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Regester()));
                      },
                          child: Text('Sign Up',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          )

                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var authService = FirebaseAuth.instance;
  void createAccountClicked(){
    if(formKey.currentState?.validate()== false){
      return;
    }
    showLoading(context, 'Loading...');
    authService.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text)
        .then((userCredential) {
      hideLoading(context);
      showMessage(context,userCredential.user?.uid ?? '');
    })
        .onError((error, stackTrace) {
      hideLoading(context);
      showMessage(context, error.toString());
    });
  }
}