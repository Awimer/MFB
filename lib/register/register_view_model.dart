import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/base.dart';
import 'package:mfb/dialoge_utils.dart';

abstract class RegisterNavigator extends BaseNavigator{

}
class RegisterViewModel extends BaseViewModel<RegisterNavigator>{

  var auth = FirebaseAuth.instance;
  void register(String email , String password)async{
    try {
      navigator?.showLoadingDialog();
      var credential= await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(credential.user?.uid ??'');
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessageDialog('Email is already registered');
      }
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('something went wrong ,please try again later');

    }
  }
}