import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/base.dart';
import 'package:mfb/data_base/my_database.dart';

import '../model/shared_data.dart';

abstract class LoginNavigator extends BaseNavigator {
  void gotoHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      navigator!.hideLoadingDialog();
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      // show message with wrong email or password
      navigator?.showMessageDialog('wrong user name or password');
    }
  }
}
