import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.pageFunction});
  final void Function(int)? pageFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: GNav(
            backgroundColor: Theme.of(context).colorScheme.background,
            tabBackgroundColor: Theme.of(context).colorScheme.secondary,
            activeColor: Theme.of(context).colorScheme.primary,
            gap: 8,
            padding: const EdgeInsets.all(16.0),
            onTabChange: (index) => pageFunction!(index),
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
    );
  }
}
