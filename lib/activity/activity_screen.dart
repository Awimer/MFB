import 'package:flutter/material.dart';

import '../register/register_screen.dart';

enum UserType { player, coach, fan }

class ActivityScreen extends StatefulWidget {
  static const String routeName = 'activity';

  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Image.asset(
                    'assets/images/activiy.png',
                    //fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'What is your Activity ?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      createUser(UserType.player);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).canvasColor,
                      side: const BorderSide(color: Colors.red),
                      minimumSize: const Size(10, 50),
                    ),
                    child: const Text(
                      'Player',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      createUser(UserType.coach);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).canvasColor,
                      side: const BorderSide(color: Colors.red),
                      minimumSize: const Size(10, 50),
                    ),
                    child: const Text(
                      'Coach',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      createUser(UserType.fan);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).canvasColor,
                      side: const BorderSide(color: Colors.red),
                      minimumSize: const Size(10, 50),
                    ),
                    child: const Text(
                      'Fan',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ],
      ),
    );
  }

  void createUser(UserType playerType) {
    switch (playerType) {
      case UserType.player:
        Navigator.pushReplacementNamed(context, Register.routeName,arguments: 'player');
        break;
      case UserType.coach:
        Navigator.pushReplacementNamed(context, Register.routeName,arguments: 'coach');
        break;
      case UserType.fan:
        Navigator.pushReplacementNamed(context, Register.routeName,arguments: 'fan');
        break;
    }
  }
}
