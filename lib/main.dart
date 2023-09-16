import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/screens/habits/habit_screen.dart';
// import 'package:side_track/screens/home_page.dart';
import 'package:side_track/themes/dark_mode.dart';
import 'package:side_track/themes/light_mode.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(dbName);
  final dbService = HabitModel();
  await dbService.prepData();
  runApp(
    ProviderScope(overrides: [
      /*NOTE: Override needed to replace db service in the other file with current one
    Seems like the above service will initiate the data  then be used through out the app
    * So I think this is a Hive gimmick/trick, at least they allow overrides
    */

      habitDBService.overrideWith((_) => dbService),
    ], child: MyApp()),
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
      home: HabitScreen(),
    );
  }
}
