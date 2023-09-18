import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/screens/notes/note_editor.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _notesList = ref.watch(notesController).getNoteList();
    return ListView.builder(
      itemCount: _notesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_notesList[index].docName),
          subtitle: Text(_notesList[index].dateTime),
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
        );
      },
    );
  }
}
