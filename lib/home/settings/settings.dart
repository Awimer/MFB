

import 'package:flutter/material.dart';
import 'package:mfb/home/settings/setting_widget.dart';

import '../../my_theme/theme_bottom_sheet.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(226, 0, 48, 1),
        title: Text('Setting',
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(child: Image.asset('assets/images/qr_code.png')),
            SizedBox(height: 30,),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.pink,
                      height: 36,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Verify Your Account",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),

                ),
              ),
              Expanded(
                child: new Container(
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.pink,
                      height: 36,
                    )),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon:Icon( Icons.person_outline_outlined,),
                      title:"Account",
                      changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                      color: Theme.of(context).canvasColor,
                      )),
                  new Container(
                    //margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(213, 213, 213, 1),
                        height: 36,
                      )),
                  InkWell(
                    onTap: (){
                      showThemeBottomSheet();
                    },
                    child: SettingsWidget(
                        pinkColor: Colors.pinkAccent,
                        changePrefixIcon:Icon( Icons.language_outlined,),
                        title:"Theme",
                        changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                            color: Theme.of(context).canvasColor
                        )),
                  ),
                  new Container(
                    //margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(213, 213, 213, 1),
                        height: 36,
                      )),
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon:Icon( Icons.notifications_none_outlined,),
                      title:"Notifications",
                      changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                          color: Theme.of(context).canvasColor
                      )),
                  new Container(
                    //margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(213, 213, 213, 1),
                        height: 36,
                      )),
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon:Icon( Icons.security_outlined,),
                      title:"Security",
                      changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                          color: Theme.of(context).canvasColor
                      )),
                  new Container(
                    //margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(213, 213, 213, 1),
                        height: 36,
                      )),
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon:Icon( Icons.report_gmailerrorred_outlined ,),
                      title:"Help",
                      changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                          color: Theme.of(context).canvasColor
                      )),
                  new Container(
                    //margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(213, 213, 213, 1),
                        height: 36,
                      )),
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon:Icon( Icons.login_outlined,),
                      title:"Log Out",
                      changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                          color: Theme.of(context).canvasColor
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showThemeBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return ThemeBottomSheet();
    });
  }
}