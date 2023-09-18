import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final _encodedNote =
        ref.watch(notesController).getJsonNote(noteDate, noteListIndex);
    //TODO Test save method, then try read from it.
    final editorState = EditorState(
      document: Document.fromJson(
        Map<String, dynamic>.from(
          json.decode(_encodedNote),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(noteTitle),
        actions: [
          MaterialButton(
            onPressed: () {},
            child: const Icon(Icons.done),
          )
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
    );
  }
}
