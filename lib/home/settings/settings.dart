import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/activity/activity_screen.dart';
import 'package:mfb/home/settings/setting_widget.dart';

import '../../login/login_screen.dart';
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(226, 0, 48, 1),
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(child: Image.asset('assets/images/qr_code.png')),
            const SizedBox(
              height: 30,
            ),
            Row(children: const <Widget>[
              Expanded(
                child: Divider(
                  thickness: 1.5,
                  color: Colors.pink,
                  height: 36,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Verify Your Account",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 1.5,
                  color: Colors.pink,
                  height: 36,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon: const Icon(
                        Icons.person_outline_outlined,
                      ),
                      title: "Account",
                      changeSuffixIcon: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Theme.of(context).canvasColor,
                      )),
                  const Divider(
                    thickness: 1,
                    color: Color.fromRGBO(213, 213, 213, 1),
                    height: 36,
                  ),
                  InkWell(
                    onTap: () {
                      showThemeBottomSheet();
                    },
                    child: SettingsWidget(
                        pinkColor: Colors.pinkAccent,
                        changePrefixIcon: const Icon(
                          Icons.format_color_fill_outlined,
                        ),
                        title: "Theme",
                        changeSuffixIcon: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Theme.of(context).canvasColor)),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromRGBO(213, 213, 213, 1),
                    height: 36,
                  ),
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon: const Icon(
                        Icons.security_outlined,
                      ),
                      title: "Security",
                      changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                          color: Theme.of(context).canvasColor)),
                  const Divider(
                    thickness: 1,
                    color: Color.fromRGBO(213, 213, 213, 1),
                    height: 36,
                  ),
                  SettingsWidget(
                      pinkColor: Colors.pinkAccent,
                      changePrefixIcon: const Icon(
                        Icons.report_gmailerrorred_outlined,
                      ),
                      title: "Help",
                      changeSuffixIcon: Icon(Icons.arrow_circle_right_outlined,
                          color: Theme.of(context).canvasColor)),
                  const Divider(
                    thickness: 1,
                    color: Color.fromRGBO(213, 213, 213, 1),
                    height: 36,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, ActivityScreen.routeName);
                    },
                    child: SettingsWidget(
                        pinkColor: Colors.pinkAccent,
                        changePrefixIcon: const Icon(
                          Icons.logout_outlined,
                        ),
                        title: "Log Out",
                        changeSuffixIcon: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Theme.of(context).canvasColor)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ThemeBottomSheet();
        });
  }
}
