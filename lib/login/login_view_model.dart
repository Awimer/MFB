import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/base.dart';

abstract class LoginNavigator extends BaseNavigator{

}
class LoginViewModel extends BaseViewModel<LoginNavigator> {

  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      navigator?.hideLoadingDialog();
          // show message with user id
      navigator?.showMessageDialog(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      // show message with wrong email or password
      navigator?.showMessageDialog('wrong user name or password');
    }
  }
}