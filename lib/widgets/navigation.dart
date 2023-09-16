import 'package:flutter/material.dart';
import 'package:side_track/screens/habits/habit_screen.dart';
import 'package:side_track/screens/notes/notes_screen.dart';
import 'package:side_track/screens/settings_page.dart';

Widget? pagesWidget(BuildContext context, int pageNumber) {
  switch (pageNumber) {
    case 0:
      return const HabitScreen();
    case 1:
      return const NotesScreen();
    case 2:
      return const Text('Stats');
    case 3:
      return const SettingsPage();
    default:
      return null;
  }
}

class HabitFAB extends StatelessWidget {
  const HabitFAB({super.key, required this.clickFunction});
  final void Function() clickFunction;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => clickFunction(),
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface));
  }
}
