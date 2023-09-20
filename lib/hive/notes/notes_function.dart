// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/hive/notes/notes_model.dart';
// import 'package:side_track/widgets/dialog_box.dart';

void saveNote(String docName, String doc, WidgetRef ref) {
  final db = ref.read(notesController);
  db.saveNote(docName, doc);
  db.syncNotes();
}

void saveEditNote(int id, String docName, Map<String, dynamic> doc,
    String createdAt, WidgetRef ref) {
  final db = ref.read(notesController);
  HiveHabitNotes _note =
      HiveHabitNotes(appflowyDoc: doc, docName: docName, dateTime: createdAt);
  db.getNoteList()[id] = _note;
  db.syncNotes();
}
/*
void addNewHabit(BuildContext context, WidgetRef ref, String habit,
    TextEditingController controller) {
  final db = ref.read(habitController);
  db.getHabitList().add([habit, false]);

  controller.clear();
  Navigator.of(context).pop();

  db.reloadData();
}

void editHabit(BuildContext context, int index,
    TextEditingController controller, WidgetRef ref) {
  final db = ref.read(notesController);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogBox(
            dialogTitle: 'Edit Note',
            cancel: () => cancel(context, controller),
            editHabitText: db.getHabitList()[index][0],
            save: (val) => saveEditHabit(context, controller, ref, index, val));
      });
}


void saveNewNote(
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

*/