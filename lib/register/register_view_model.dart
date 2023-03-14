import 'package:firebase_auth/firebase_auth.dart';
import 'package:mfb/base.dart';
import 'package:mfb/data_base/my_database.dart';
import 'package:mfb/model/player_model.dart';
import 'package:mfb/model/shared_data.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void gotoHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var auth = FirebaseAuth.instance;

  void register(
    String email,
    String password,
    String userName,
    String phone,
    String userType
  ) async {
    navigator?.showLoadingDialog();
    try {
      var credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      PlayerModel newUser = PlayerModel(
          id: credential.user!.uid,
          phone: phone,
          userName: userName,
          email: email,
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

      var insertedUser = await MyDataBase.insertUser(newUser);
      if (insertedUser != null) {
        // user inserted successfully
        SharedData.user = insertedUser;
        navigator?.gotoHome();
      } else {
        // error with database, show error
        navigator
            ?.showMessageDialog('something went wrong, error with data base');
      }
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('Account Created Successfully :)');
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadingDialog();
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessageDialog('Email is already registered');
      }
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator
          ?.showMessageDialog('something went wrong ,please try again later');
    }
  }
}
