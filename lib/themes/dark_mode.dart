import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  iconTheme: IconThemeData(color: Colors.grey.shade400),
  primaryColor: Colors.white,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade800,
    primary: Colors.white60,
    secondary: Colors.grey.shade400,
    onSurface: Colors.black87,
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
);
