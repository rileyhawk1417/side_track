import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/notes/notes_function.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/screens/notes/edit_note.dart';
import 'package:side_track/screens/notes/add_note.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteLength = ref.watch(notesController).syncNotes();
    final box = Hive.box<HiveHabitNotes>(notesDBName);
    return Scaffold(
      body: ListView.builder(
        itemCount: noteLength!.length,
        itemBuilder: (context, index) {
          int keyList = noteLength[index];
          HiveHabitNotes? _note = box.get(keyList);
          var noteYear = _note!.dateTime.substring(0, 4);
          var noteMonth = _note.dateTime.substring(4, 6);
          var noteDay = _note.dateTime.substring(6, 8);
          return Slidable(
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                  backgroundColor: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(2),
                  onPressed: (context) {
                    ref.read(notesController).deleteNote(index);
                  },
                  icon: Icons.delete),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title:
                      Text(_note.docName, style: const TextStyle(fontSize: 18)),
                  subtitle: Text('Created on: $noteYear/$noteMonth/$noteDay',
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14)),
                  onTap: () {
                    Get.to(
                      () => NoteEditor(
                        noteData: _note.appflowyDoc,
                        noteTitle: _note.docName,
                        noteListIndex: keyList,
                        noteDate: _note.dateTime,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () => Get.to(() => AddNewNote()),
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
