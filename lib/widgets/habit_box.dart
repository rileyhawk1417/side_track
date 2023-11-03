import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:side_track/hive/habits/habit_model.dart';

class HabitBox extends ConsumerStatefulWidget {
  const HabitBox({
    super.key,
    required this.habitText,
    required this.habitCompleted,
    required this.edit,
    required this.delete,
    required this.index,
  });

  final String habitText;
  final int index;
  final bool habitCompleted;
  final Function(BuildContext)? edit;
  final Function(BuildContext)? delete;

  @override
  HabitBoxState createState() => HabitBoxState();
}

class HabitBoxState extends ConsumerState<HabitBox> {
  @override
  Widget build(BuildContext context) {
    bool val = widget.habitCompleted;
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => widget.edit!(context),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: (context) => widget.delete!(context),
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: SizedBox(
        //TODO: Remove hard coded size
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
                visualDensity: const VisualDensity(vertical: 4),
                splashColor: Colors.green,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12.0)),
                //TODO: Refactor this code
                title: val
                    ? Text(
                        widget.habitText,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      )
                    : Text(widget.habitText),
                //TODO: Add opacity when task completed
                tileColor: Theme.of(context).colorScheme.secondary,
                leading: Checkbox(
                  value: val,
                  onChanged: (truth) => {},
                ),
                trailing: const Icon(Icons.arrow_back),
                onTap: () {
                  val = !val;
                  ref.read(habitController).onCheckBoxTapped(val, widget.index);
                }),
          ),
        ),
      ),
    );
  }
}
