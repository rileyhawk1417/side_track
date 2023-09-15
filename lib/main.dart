import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:side_track/hive/habit_model.dart';
import 'package:side_track/screens/home_page.dart';
import 'package:side_track/themes/dark_mode.dart';
import 'package:side_track/themes/light_mode.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(dbName);
  runApp(
    ChangeNotifierProvider(
        create: (context) => HabitModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Side Track',
      theme: lightMode,
      darkTheme: darkMode,
      home: const HomePage(),
    );
  }
}
