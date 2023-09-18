import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/widgets/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}

int _pageNumber = 0;

//NOTE: Main Widget

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //TODO: Switch this to a riverpod
        body: pagesWidget(context, _pageNumber),
        appBar: AppBar(
          title: const Text('Side Track'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: GNav(
                backgroundColor: Theme.of(context).colorScheme.background,
                tabBackgroundColor: Theme.of(context).colorScheme.secondary,
                gap: 8,
                padding: const EdgeInsets.all(16.0),
                onTabChange: (index) {
                  setState(() {
                    _pageNumber = index;
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(icon: Icons.notes, text: 'Notes'),
                  GButton(icon: Icons.query_stats_outlined, text: 'Stats'),
                  GButton(icon: Icons.settings, text: 'Settings'),
                ]),
          ),
        ),
      ),
    );
  }
}
