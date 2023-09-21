// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/hive/notes/notes_model.dart';

final notesController = ChangeNotifierProvider<NotesDBController>((ref) {
  final notesData = ref.watch(notesDBService);
  return NotesDBController(notesData);
});

class NotesDBController extends ChangeNotifier {
  NotesDBController(this._notes_database);
  late final NotesModel _notes_database;

  void prepData() {
    _notes_database.prepData();
  }

  void saveEditNote(int id, String title, Map<String, dynamic> doc) {
    HiveHabitNotes? noteDate = _notes_database.notesBox.get(id);
    HiveHabitNotes editedNotes = HiveHabitNotes(
        appflowyDoc: doc, docName: title, dateTime: noteDate!.dateTime);
    _notes_database.notesBox.put(id, editedNotes);
    notifyListeners();
  }

  List<int>? syncNotes() {
    return _notes_database.loadNoteKeys();
  }

  int getNumberOfNotes() {
    return _notes_database.notesBox.keys.length;
  }

  void addNote(HiveHabitNotes note) {
    _notes_database.addNewNote(note);
    notifyListeners();
  }

  HiveHabitNotes findNote(int index) {
    HiveHabitNotes? searchedNote = _notes_database.notesBox.get(index);
    return searchedNote!;
  }

  void deleteNote(int noteIndex) {
    _notes_database.deleteNote(noteIndex);
    notifyListeners();
  }
}

final notesDBService = Provider<NotesModel>((_) => NotesModel());
