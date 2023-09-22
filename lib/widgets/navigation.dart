import 'package:flutter/material.dart';

class HabitFAB extends StatelessWidget {
  const HabitFAB({super.key, required this.clickFunction});
  final void Function() clickFunction;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => clickFunction(),
          child: const Icon(
            Icons.add,
          )),
    );
  }
}
