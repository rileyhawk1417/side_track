import 'package:flutter/material.dart';
import 'package:side_track/components/bottom_navbar.dart';
import 'package:side_track/screens/habits/habit_screen.dart';
import 'package:side_track/screens/notes/notes_screen.dart';
import 'package:side_track/screens/settings/settings_page.dart';
import 'package:side_track/screens/stats/stats_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}

final List<Widget> _pages = [
  const HabitScreen(),
  const NotesScreen(),
  const StatsPage(),
  const SettingsPage(),
];

class _HomePage extends State<HomePage> {
  int _pageIndex = 0;
  void pageNavigation(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      appBar: AppBar(
        title: const Text('Side Track'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: BottomNav(
        pageFunction: (index) => pageNavigation(index),
      ),
    );
  }
}
