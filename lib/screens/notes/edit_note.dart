import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:side_track/hive/notes/notes_function.dart';
import 'package:side_track/hive/notes/notes_model.dart';
part 'note_editor.g.dart';

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
    final editorScrollController = ScrollController();
    var _editable = ref.watch(editableProvider);
    var _noteTitle =
        ref.watch(notesController).getNoteList()[noteListIndex].docName;
    final _encodedNote =
        ref.watch(notesController).getJsonNote(noteDate, noteListIndex);
    final editorState = EditorState(
      document: Document.fromJson(
        Map<String, dynamic>.from(
          json.decode(_encodedNote),
        ),
      ),
    );
    TextEditingController editTitle = TextEditingController(text: _noteTitle);
    void saveNoteEdit() {
      print('lolz');
      ref.read(editableProvider.notifier).editable();
      saveEditNote(noteListIndex, editTitle.text, editorState.document.toJson(),
          noteDate, ref);
      ref.read(notesController).syncNotes();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _editable
              ? TextField(
                  controller: editTitle,
                )
              : Text(_noteTitle),
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
