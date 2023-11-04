import 'package:flutter/material.dart';
import 'package:side_track/components/adaptive_text.dart';
import 'package:side_track/components/link_buttons.dart';
import 'package:side_track/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          child: AdaptiveText(
            text: 'About the app',
            scaleFactor: 2.0,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          child: AdaptiveText(
            text:
                'The app is just for tracking habits & making notes while you are at it',
            alignment: TextAlign.center,
          ),
        ),
        const LinkButton(
          text: 'Github Project',
          linkText: 'https://github.com/rileyhawk1417/side_track',
          //TODO: Replace this icon to be a globe one
          icon: Icons.link_rounded,
          alignment: MainAxisAlignment.center,
          boxWidth: 200,
        ),
        AdaptiveText(text: 'Installed version: $appVersion'),
        const SizedBox(height: 300),
        const SizedBox(
          child: AdaptiveText(text: 'Open source made with Flutter'),
        )
      ],
    ));
  }
}
