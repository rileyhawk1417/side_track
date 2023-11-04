import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/hive/notes/notes_function.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/screens/home_page.dart';
import 'package:side_track/themes/dark_mode.dart';
import 'package:side_track/themes/light_mode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:upgrader/upgrader.dart';

String appVersion = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo pkgInfo = await PackageInfo.fromPlatform();
  appVersion = pkgInfo.version;
  Hive.registerAdapter(HiveHabitNotesAdapter());
  await Hive.initFlutter();
  await Hive.openBox(dbName);
  await Hive.openBox<HiveHabitNotes>(notesDBName);
  final habitService = HabitModel();
  final notesService = NotesModel();
  await habitService.prepData();
  await notesService.prepData();

  await Upgrader.clearSavedSettings();
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
    //TODO: Add this config in later
    /*
    final appcastURL =
        'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return MaterialApp(
      title: 'Upgrader demo',
      home: Scaffold(
          appBar: AppBar(title: Text('Upgrader')),
          body: Column(children: [
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
              child: UpgradeCard(
                  upgrader: Upgrader(
                      appcastConfig: cfg, showIgnore: true, showLater: true)),
            ),
            Text('Checking for update!!!')
          ])),
    );
    */
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
