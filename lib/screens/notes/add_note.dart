import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:side_track/hive/notes/notes_function.dart';
import 'package:side_track/hive/notes/notes_model.dart';


List<MobileToolbarItem> mobileToolBar = [
  textDecorationMobileToolbarItem,
  buildTextAndBackgroundColorMobileToolbarItem(),
  headingMobileToolbarItem,
  todoListMobileToolbarItem,
  listMobileToolbarItem,
  linkMobileToolbarItem,
  quoteMobileToolbarItem,
  dividerMobileToolbarItem,
  codeMobileToolbarItem,
];

class AppBarButton extends StatelessWidget {
  const AppBarButton(
      {super.key, required this.onPressedFunc, required this.icon});
  final void Function() onPressedFunc;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: SizedBox(
          height: 120.0,
          width: 55.0,
          child: MaterialButton(
            onPressed: () => onPressedFunc(),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}

class AddNewNote extends ConsumerWidget {
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorScrollController = ScrollController();
    //TODO: Fix the blank slate
    final editorState = EditorState.blank(withInitialText: false);
    TextEditingController editTitle = TextEditingController();
    /*
    var _noteTitle =
        ref.watch(notesController).getNoteList()[noteListIndex].docName;
    final _encodedNote =
        ref.watch(notesController).getJsonNote(noteDate, noteListIndex);
    */
    void saveNewNote() {
    /*
      saveEditNote(noteListIndex, editTitle.text, editorState.document.toJson(),
          noteDate, ref);
    */
    //Save the note
      ref.read(notesController).syncNotes();
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
            TextField(
                  controller: editTitle,
                )
              ,
          actions: [
            AppBarButton(
                    onPressedFunc: () => saveNewNote(), icon: Icons.done)
                ,
            const SizedBox(
              height: 10,
              width: 10,
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AppFlowyEditor(
                editable: true,
                editorStyle: const EditorStyle.mobile(),
                editorState: editorState,
                scrollController: editorScrollController,
              ),
            ),
            MobileToolbar(editorState: editorState, toolbarItems: mobileToolBar)
          ],
        ),
      ),
    );
  }
}
