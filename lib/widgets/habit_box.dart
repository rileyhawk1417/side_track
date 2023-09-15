import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitBox extends StatelessWidget {
  const HabitBox(
      {super.key,
      required this.habitText,
      required this.habitCompleted,
      required this.onChanged,
      required this.edit,
      required this.delete});

  final String habitText;
  final bool habitCompleted;
  final Function(bool?) onChanged;
  final Function(BuildContext)? edit;
  final Function(BuildContext)? delete;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => edit!(context),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: (context) => delete!(context),
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Checkbox(value: habitCompleted, onChanged: onChanged),
            Text(habitText),
          ]),
        ),
      ),
    );
  }
}
