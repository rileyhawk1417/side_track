import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  const AdaptiveText(
      {super.key,
      required this.text,
      this.scaleFactor,
      this.alignment,
      this.textStyle});
  final String text;
  final TextAlign? alignment;
  final double? scaleFactor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: scaleFactor,
      textAlign: alignment,
      style: textStyle ?? TextStyle(color: Theme.of(context).primaryColor),
    );
  }
}
