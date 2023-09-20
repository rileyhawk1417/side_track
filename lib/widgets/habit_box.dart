import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitBox extends StatelessWidget {
  const HabitBox({
    super.key,
    required this.habitText,
    required this.habitCompleted,
    required this.onChanged,
    required this.edit,
    required this.delete,
  });

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
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
              title: Text(habitText),
              /*
              //BUG: Does work but delays heat map
              leading: habitCompleted
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank_sharp),
                  */
              leading: Checkbox(
                value: habitCompleted,
                onChanged: onChanged,
              ),
              onTap: () {
                //TODO: Pass bool function here
                // checkBoxTapped(!habitCompleted, index, ref);
              }),
        ),
      ),
    );
  }
}
