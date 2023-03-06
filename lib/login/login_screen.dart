import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/forget_password/forget_password.dart';
import 'package:mfb/register/register_screen.dart';
import 'package:mfb/register/validation_utils.dart';
import 'package:provider/provider.dart';

import '../base.dart';
import '../home/home_layout.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  bool securedPassword = true;

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 50.0,
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
                          return 'please enter password';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ForgetScreen()));
                            },
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () {
                        signIN();
                      },
                      minWidth: double.infinity,
                      color: Colors.red,
                      height: 50,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text('Dont have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Register()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  var authService = FirebaseAuth.instance;
  void signIN() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.login(
      emailController.text,
      passwordController.text,
    );
  }

  @override
  void gotoHome() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeLayout()));
  }
}
