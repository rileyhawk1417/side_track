import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:side_track/components/appbar_button.dart';
import 'package:side_track/hive/notes/notes_function.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/themes/constants.dart';
part 'edit_note.g.dart';

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

@riverpod
class Editable extends _$Editable {
  @override
  bool build() => false;

  void editable() => state = !state;
}


class NoteEditor extends ConsumerWidget {
  final Map<String, dynamic> noteData;
  final String noteTitle;
  final int noteListIndex;
  final String noteDate;

  const NoteEditor({
    super.key,
    required this.noteData,
    required this.noteTitle,
    required this.noteListIndex,
    required this.noteDate,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HiveHabitNotes searchedNote =
        ref.watch(notesController).findNote(noteListIndex);
    var _editable = ref.watch(editableProvider);
    final _encodedNote = jsonEncode(searchedNote.appflowyDoc);
    final editorState = EditorState(
      document: Document.fromJson(
        Map<String, dynamic>.from(
          json.decode(_encodedNote),
        ),
      ),
    );

    final editorScrollController =
        EditorScrollController(editorState: editorState);
    TextEditingController editTitle = TextEditingController(text: noteTitle);
    void saveNoteEdit() {
      ref.read(editableProvider.notifier).editable();
      ref.read(notesController).saveEditNote(
          noteListIndex, editTitle.text, editorState.document.toJson());
      ref.read(notesController).syncNotes();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarButton(
              onPressedFunc: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back),
          title: _editable
              ? TextField(
                  decoration: const InputDecoration(focusColor: Colors.blue),
                  controller: editTitle,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )
              : Text(noteTitle),
          actions: [
            _editable
                ? AppBarButton(
                    onPressedFunc: () => saveNoteEdit(), icon: Icons.done)
                : AppBarButton(
                    onPressedFunc: () =>
                        ref.read(editableProvider.notifier).editable(),
                    icon: Icons.edit),
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
                editable: _editable,
                editorStyle: EditorStyle.mobile(
                  textStyleConfiguration: editorTextStyle(context),
                ),
                editorState: editorState,
                editorScrollController: editorScrollController,
              ),
            ),
            MobileToolbar(editorState: editorState, toolbarItems: mobileToolBar)
          ],
        ),
      ),
    );
  }
}
