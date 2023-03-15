
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mfb/base.dart';



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
      navigator!.gotoHome();

    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      // show message with wrong email or password
      navigator?.showMessageDialog('wrong user name or password',);
    }
  }
}
