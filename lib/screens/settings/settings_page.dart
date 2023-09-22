import 'package:flutter/material.dart';
import 'package:side_track/components/adaptive_text.dart';
import 'package:side_track/components/link_buttons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        SizedBox(
          child: AdaptiveText(
            text: 'About the app',
            scaleFactor: 2.0,
          ),
        ),
        SizedBox(
          width: 180.0,
          child: AdaptiveText(
            text:
                'The app is just for tracking habits & making notes while you are at it',
            alignment: TextAlign.center,
          ),
        ),
        LinkButton(
          text: 'Github Project',
          linkText: 'https://github.com/rileyhawk1417/side_track',
          icon: Icons.link,
          alignment: MainAxisAlignment.center,
          boxWidth: 200,
        ),
        LinkButton(
          text: 'Developer Profile',
          linkText: 'https://github.com/rileyhawk1417/',
          icon: Icons.link,
          alignment: MainAxisAlignment.center,
          boxWidth: 200,
        ),
        SizedBox(height: 300),
        SizedBox(
          child: AdaptiveText(text: 'Open source made with Flutter'),
        )
      ],
    ));
  }
}
