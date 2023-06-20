import 'package:flutter/material.dart';
import 'package:mfb/model/player_model.dart';

class RatePlayer extends StatefulWidget {
  static const String routeName = '/rateskil';
  const RatePlayer({super.key});

  @override
  State<RatePlayer> createState() => _RatePlayerState();
}

enum Skils {
  pace,
  shooting,
  passing,
  dribbling,
  defending,
  physical,
}

class _RatePlayerState extends State<RatePlayer> {
  final List<String> skils = [
    'Pace',
    'Shooting',
    'Passing',
    'Dribbling',
    'Defending',
    'Physical',
  ];

  double pace = 0;
  double shooting = 0;
  double passing = 0;
  double dribbling = 0;
  double defending = 0;
  double physical = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate player skils'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Text('Pace'),
            title: Slider(
              value: pace,
              divisions: 100,
              onChanged: (value) {
                pace = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            leading: const Text('Shooting'),
            title: Slider(
              divisions: 100,
              value: shooting,
              onChanged: (value) {
                shooting = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            leading: const Text('Passing'),
            title: Slider(
              divisions: 100,
              value: passing,
              onChanged: (value) {
                passing = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            leading: const Text('Dribbling'),
            title: Slider(
              divisions: 100,
              value: dribbling,
              onChanged: (value) {
                dribbling = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            leading: const Text('Defending'),
            title: Slider(
              divisions: 100,
              value: defending,
              onChanged: (value) {
                defending = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            leading: const Text('Physical'),
            title: Slider(
              divisions: 100,
              value: physical,
              onChanged: (value) {
                physical = value;
                setState(() {});
              },
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Done'))
        ],
      ),
    );
  }
}
