import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/hive/notes/notes_function.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/screens/home_page.dart';
import 'package:side_track/themes/dark_mode.dart';
import 'package:side_track/themes/light_mode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Hive.registerAdapter(HiveHabitNotesAdapter());
  await Hive.initFlutter();
  await Hive.openBox(dbName);
  await Hive.openBox<HiveHabitNotes>(notesDBName);
  final habitService = HabitModel();
  final notesService = NotesModel();
  await habitService.prepData();
  await notesService.prepData();
  runApp(
    ProviderScope(overrides: [
      /*NOTE: Override needed to replace db service in the other file with current one
    Seems like the above service will initiate the data  then be used through out the app
    * So I think this is a Hive gimmick/trick, at least they allow overrides
    */
      notesDBService.overrideWith((_) => notesService),
      habitDBService.overrideWith((_) => habitService),
    ], child: const MyApp()),
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppFlowyEditorLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', 'US')],
      home: const HomePage(),
    );
  }
}
