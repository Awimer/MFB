import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfb/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool securedPassword = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logo.png'),
                Text('Login',
                  style: TextStyle(
                    fontSize: 50.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator:(text){
                    if (text == null || text.trim().isEmpty){
                      return 'please enter full name';
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
                  validator:(text){
                    if (text == null || text.trim().isEmpty){
                      return 'please enter password';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: Text('Forget Password',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )),
                  ],
                ),
                MaterialButton(onPressed: (){
                  createAccountClicked();
                },
                  minWidth: double.infinity,
                  child: Text('Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  color: Colors.red,
                  height: 50,

                ),
                Row(
                  children: [
                    Text('Dont have an account?'),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Regester()));
                    },
                        child: Text('Sign Up',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                          ),
                        )

                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccountClicked(){
    if(formKey.currentState?.validate()== false){
      return;
    }
  }
}

