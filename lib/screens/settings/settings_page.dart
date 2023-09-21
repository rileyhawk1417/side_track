import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        SizedBox(
          child: Text(
            'About the app',
            textScaleFactor: 2.0,
          ),
        ),
        SizedBox(
          width: 2.0,
          child: Text(
            'The app is just for tracking habits & making notes while you are at it',
          ),
        ),
      ],
    ));
  }
}
