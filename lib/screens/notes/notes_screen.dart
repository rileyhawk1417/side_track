import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/screens/notes/edit_note.dart';
import 'package:side_track/screens/notes/add_note.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _notesList = ref.watch(notesController).getNoteList();
    return Scaffold(
      body: ListView.builder(
        itemCount: _notesList.length,
        itemBuilder: (context, index) {
          var noteYear = _notesList[index].dateTime.substring(0, 4);
          var noteMonth = _notesList[index].dateTime.substring(4, 6);
          var noteDay = _notesList[index].dateTime.substring(6, 8);
          return Slidable(
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(onPressed: (context) {}, icon: Icons.delete),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(_notesList[index].docName,
                      style: const TextStyle(fontSize: 18)),
                  subtitle: Text('Created on: $noteYear/$noteMonth/$noteDay',
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14)),
                  onTap: () {
                    Get.to(
                      () => NoteEditor(
                        noteData: _notesList[index].appflowyDoc,
                        noteTitle: _notesList[index].docName,
                        noteListIndex: index,
                        noteDate: _notesList[index].dateTime,
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
