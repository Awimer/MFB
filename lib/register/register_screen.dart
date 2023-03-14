import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/home_layout.dart';
import 'package:mfb/register/register_view_model.dart';
import 'package:mfb/register/validation_utils.dart';
import 'package:provider/provider.dart';

import '../base.dart';
import '../login/login_screen.dart';
import '../model/player_model.dart';

class Register extends StatefulWidget {
  static const String routeName = 'register';

  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool securedPassword = true;
  String userType = 'fan';

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  Widget build(BuildContext context) {
    userType = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Theme.of(context).colorScheme.error,
          onPressed: () =>
              Navigator.pushReplacementNamed(context, LoginScreen.routeName),
        ),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  const Text(
                    'Regester',
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: userNameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter User Name';
                      }
                      if (text.length < 3) {
                        return 'User Name must be more than 2 char';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'User Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter Email';
                      }
                      if (!ValidationUtils.isValidEmail(text)) {
                        return 'please enter a valid Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: securedPassword,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter Password';
                      }
                      if (text.length < 8) {
                        return 'Password should be at least 8 chars';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: InkWell(
                        onTap: () {
                          securedPassword = !securedPassword;
                          setState(() {});
                        },
                        child: Icon(
                          securedPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: phoneController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter phone number';
                      }
                      if (text.length != 11) {
                        return 'Phone Number must be of 11 digit';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      createAccountClicked();
                    },
                    minWidth: double.infinity,
                    color: Colors.red,
                    height: 50,
                    child: const Text('Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        )),
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
  void createAccountClicked() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      PlayerModel newUser = PlayerModel(
          id: credential.user!.uid,
          phone: phoneController.text,
          userName: userNameController.text,
          email: emailController.text,
          imageUrl: '',
          about: '',
          age: 0,
          playerHeight: 0,
          playerPosition: '',
          weight: 0,
          likeCounter: 0,
          isLiked: false,
          location: '',
          totalRating: 0,
          fanRating: [],
          averageRating: 0,
          userType: userType);

      FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set(newUser.toMap())
          .then((value) {
        emailController.clear();
        passwordController.clear();
        phoneController.clear();
        userNameController.clear();
        Navigator.pushNamed(context, HomeLayout.routeName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      print(e);
    }
  }
}
