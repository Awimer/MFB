import 'package:firebase_auth/firebase_auth.dart';
import 'package:mfb/base.dart';
import 'package:mfb/data_base/my_database.dart';

import '../shared_data.dart';

abstract class LoginNavigator extends BaseNavigator{
  void gotoHome();
}
class LoginViewModel extends BaseViewModel<LoginNavigator> {

  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password);
       // get user from data base
      var retrievedUser = await MyDataBase.getUserById(credential.user?.uid ?? '');
      navigator?.hideLoadingDialog();
      if(retrievedUser == null){
        navigator?.showMessageDialog('something went wrong,'
            'wrong user name or password');
      }else {
        // goto home
        SharedData.user = retrievedUser;
        navigator?.gotoHome();
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      // show message with wrong email or password
      navigator?.showMessageDialog('wrong user name or password');
    }
  }
}