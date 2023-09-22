import 'package:flutter/material.dart';
import 'package:side_track/components/adaptive_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkButton extends StatelessWidget {
  const LinkButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.alignment,
      required this.linkText,
      required this.boxWidth});
  final String text;
  final IconData icon;
  final MainAxisAlignment? alignment;
  final String linkText;
  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: TextButton(
        onPressed: () => launchUrlString(linkText),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            AdaptiveText(text: text)
          ],
        ),
      ),
    );
  }
}
