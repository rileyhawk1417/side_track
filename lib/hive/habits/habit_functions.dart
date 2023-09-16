import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/widgets/dialog_box.dart';

//NOTE: Collection of functions for the habit tracker
void checkBoxTapped(bool? value, int index, WidgetRef ref) {
  final db = ref.read(habitController);
  db.onCheckBoxTapped(value, index);
}

void cancel(BuildContext context, TextEditingController controller) {
  controller.clear();
  Navigator.of(context).pop();
}

void saveEditHabit(BuildContext context, TextEditingController controller,
    WidgetRef ref, int index, String val) {
  final db = ref.read(habitController);

  db.getHabitList()[index][0] = val;
  controller.clear();
  Navigator.of(context).pop();
  db.reloadData();
}

void deleteHabit(int index, BuildContext context, WidgetRef ref) {
  final db = ref.watch(habitController);
  db.getHabitList().removeAt(index);
  db.reloadData();
}

void editHabit(BuildContext context, int index,
    TextEditingController controller, WidgetRef ref) {
  final db = ref.read(habitController);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogBox(
            dialogTitle: 'Edit Habit',
            cancel: () => cancel(context, controller),
            editHabitText: db.getHabitList()[index][0],
            save: (val) => saveEditHabit(context, controller, ref, index, val));
      });
}

void saveNewHabit(
    BuildContext context, TextEditingController controller, WidgetRef ref) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogBox(
          cancel: () => cancel(context, controller),
          save: (value) {
            addNewHabit(context, ref, value, controller);
          },
          dialogTitle: 'Add New Habit',
        );
      });
}

void addNewHabit(BuildContext context, WidgetRef ref, String habit,
    TextEditingController controller) {
  final db = ref.watch(habitController);
  db.getHabitList().add([habit, false]);

  controller.clear();
  Navigator.of(context).pop();

  db.reloadData();
}
