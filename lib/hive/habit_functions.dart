import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_track/hive/habit_model.dart';
import 'package:side_track/widgets/alert_box.dart';

void checkBoxTapped(bool? value, int index, BuildContext context) {
  final db = context.read<HabitModel>();
  db.todaysHabitList[index][1] = value;
  db.updateData();
}

void cancel(BuildContext context, TextEditingController controller) {
  controller.clear();
  Navigator.of(context).pop();
}

void saveEditHabit(BuildContext context, TextEditingController controller,
    HabitModel db, int index, String val) {
  db.todaysHabitList[index][0] = val;
  controller.clear();
  Navigator.of(context).pop();
  db.updateData();
}

void deleteHabit(int index, BuildContext context) {
  final db = context.read<HabitModel>();
  db.todaysHabitList.removeAt(index);
  db.updateData();
}

void editHabit(
    BuildContext context, int index, TextEditingController controller) {
  final db = context.read<HabitModel>();
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogBox(
            dialogTitle: 'Edit Habit',
            cancel: () => cancel(context, controller),
            editHabitText: db.todaysHabitList[index][0],
            save: (val) => saveEditHabit(context, controller, db, index, val));
      });
}

void saveNewHabit(BuildContext context, TextEditingController controller) {
  final db = context.read<HabitModel>();
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogBox(
          cancel: () => cancel(context, controller),
          save: (value) {
            addNewHabit(context, db, value, controller);
          },
          dialogTitle: 'Add New Habit',
        );
      });
}

void addNewHabit(BuildContext context, HabitModel db, String habit,
    TextEditingController controller) {
  db.todaysHabitList.add([habit, false]);

  controller.clear();
  Navigator.of(context).pop();

  db.updateData();
}
