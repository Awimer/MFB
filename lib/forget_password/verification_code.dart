import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifictionCode extends StatelessWidget {
  static const String routeName = 'verification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:Text('Verifiction Code',
          style: TextStyle(
              color: Colors.black
          ),
        ) ,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter The Code That Was Send To',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20,),
              Image.asset('assets/images/verification.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Enter your code',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height:86,
                        width: 64,
                        child: Container(
                          child: TextFormField(
                            onChanged: (value){
                              if(value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (pin2){},
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(255, 231, 228, 1),)
                              ),
                              hintText: '0',
                              filled: true,
                              fillColor: Color.fromRGBO(255, 231, 228, 1),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: SizedBox(
                        height:86,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration:
                          const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent)
                            ),
                            hintText: '0',
                            filled: true,
                            fillColor: Color.fromRGBO(255, 231, 228, 1),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: SizedBox(
                        height:86,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(255, 231, 228, 1)),
                            ),
                            hintText: '0',
                            filled: true,
                            fillColor: Color.fromRGBO(255, 231, 228, 1),
                            border: OutlineInputBorder(),
                          ),

                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: SizedBox(
                        height:86,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent)
                            ),
                            hintText: '0',
                            filled: true,
                            fillColor: Color.fromRGBO(255, 231, 228, 1),
                            border: OutlineInputBorder(),
                          ),

                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: SizedBox(
                        height:86,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent)
                            ),
                            hintText: '0',
                            filled: true,
                            fillColor: Color.fromRGBO(255, 231, 228, 1),
                            border: OutlineInputBorder(),
                          ),

                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: SizedBox(
                        height:86,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent)
                            ),
                            hintText: '0',
                            filled: true,
                            fillColor: Color.fromRGBO(255, 231, 228, 1),
                            border: OutlineInputBorder(
                            ),
                          ),

                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(onPressed: (){
              },
                minWidth: double.infinity,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.red)
                ),
                child: Text('Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: Colors.redAccent.shade700,
                height: 50,

              ),
              Row(
                children: [
                  Text("Don't Receiving a code?",
                    style: TextStyle(
                    fontSize: 14,
                      color: Colors.grey.shade700,
                  ),),
                  TextButton(onPressed: (){},
                      child: Text('Resend code',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.redAccent.shade700,
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
    );
  }
}