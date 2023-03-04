import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/home_layout.dart';
import 'package:mfb/register/register_view_model.dart';
import 'package:mfb/register/validation_utils.dart';
import 'package:provider/provider.dart';

import '../base.dart';

class Register extends StatefulWidget {
  static const String routeName = 'register';
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends BaseState<Register,RegisterViewModel>
implements RegisterNavigator {
  bool securedPassword = true;

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
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: Theme.of(context).errorColor,
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
                    Text('Regester',
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: userNameController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter User Name';
                        }
                        if (text.length < 3) {
                          return 'User Name must be more than 2 char';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: emailController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter Email';
                        }
                        if(!ValidationUtils.isValidEmail(text)){
                          return 'please enter a valid Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),

                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      obscureText: securedPassword,
                      controller: passwordController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter Password';
                        }
                        if (text.length <8) {
                          return 'Password should be at least 8 chars';
                        }
                        return null;
                      },
                      decoration: InputDecoration(

                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: (){
                            securedPassword =!securedPassword;
                            setState(() {

                            });
                          },
                          child: Icon(
                            securedPassword ?
                            Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: phoneController,
                      validator:(text){
                        if (text == null || text.trim().isEmpty){
                          return 'please enter phone number';
                        }
                        if(text.length != 11){
                          return 'Phone Number must be of 11 digit';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),

                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Player Position',
                        border: OutlineInputBorder(),
                      ),

                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Country',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    /*Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Nationality',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Nationality',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Nationality',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),*/
                    MaterialButton(onPressed: (){
                      createAccountClicked();
                    },
                      minWidth: double.infinity,
                      child: Text('Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      color: Colors.red,
                      height: 50,

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
  void createAccountClicked(){
    if(formKey.currentState?.validate()== false){
      return;
    }
    viewModel.register(emailController.text, passwordController.text,userNameController.text,phoneController.text);
  }

  @override
  void gotoHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeLayout()));
  }

}