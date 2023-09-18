import 'package:flutter/material.dart';

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
