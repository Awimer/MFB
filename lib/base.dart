import 'package:flutter/cupertino.dart';

import 'dialoge_utils.dart';

abstract class BaseNavigator {
  // interface
  void showLoadingDialog({String message = 'Loading...'});
  void hideLoadingDialog();
  void showMessageDialog(String message);
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();
  @override
  void showLoadingDialog({String message = 'Loading...'}) {
    showLoading(context, message);
  }

  @override
  void hideLoadingDialog() {
    hideLoading(context);
  }

  @override
  void showMessageDialog(String message) {
    showMessage(context, message);
  }
}
