import 'package:flutter/material.dart';

class Regester extends StatefulWidget {
  static const String routeName = 'register';
  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  bool securePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image/Vector.png'),
                Text('Regester',
                  style: TextStyle(
                    fontSize: 50.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: InkWell(
                      onTap: (){
                        securePassword =!securePassword;
                        setState(() {

                        });
                      },
                      child: Icon(
                        securePassword ?
                        Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),

                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),

                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Gmail',
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
                    hintText: 'Nationality',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
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
                SizedBox(height: 20.0,),
                Row(
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
                SizedBox(height: 20,),
                MaterialButton(onPressed: (){
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
                    TextButton(onPressed: (){},
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
}