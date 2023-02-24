import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class LoginNavigator{
  void showLoading ();
}
class LoginViewModel extends ChangeNotifier {
  LoginNavigator? navigator;

  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoading();
      var credential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password);
          // show message with user id
    } on FirebaseAuthException catch (e) {
      // show message with wrong email or password

    }
  }
}