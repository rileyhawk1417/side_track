import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/components/appbar_button.dart';
import 'package:side_track/hive/notes/notes_function.dart';
import 'package:side_track/hive/notes/notes_model.dart';
import 'package:side_track/hive/utils/date_time.dart';
import 'package:side_track/themes/constants.dart';

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

class AddNewNote extends ConsumerWidget {
  const AddNewNote({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _prepDoc =
        jsonEncode(EditorState.blank(withInitialText: true).document.toJson());

    final editorState = EditorState(
      document: Document.fromJson(
        Map<String, Object>.from(
          json.decode(_prepDoc),
        ),
      ),
    );

    final editorScrollController =
        EditorScrollController(editorState: editorState);
    TextEditingController editTitle = TextEditingController();
    void saveNewNote() {
      HiveHabitNotes _newNote = HiveHabitNotes(
          appflowyDoc: editorState.document.toJson(),
          docName: editTitle.text,
          dateTime: todaysDateFormatted());

      ref.read(notesController).addNote(_newNote);

      ref.read(notesController).syncNotes();
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarButton(
              onPressedFunc: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back),
          title: TextField(
            controller: editTitle,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          actions: [
            AppBarButton(onPressedFunc: () => saveNewNote(), icon: Icons.done),
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
                editorStyle: EditorStyle.mobile(
                    textStyleConfiguration: editorTextStyle(context)),
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
