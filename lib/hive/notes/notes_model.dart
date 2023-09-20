import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/hive/notes/sample.dart';
import 'package:side_track/hive/utils/date_time.dart';
part 'notes_model.g.dart';

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

  void saveNote(String docName, String doc) {
    final convertedDoc = jsonDecode(doc);
    _notes_database._notesList.add(HiveHabitNotes(
        appflowyDoc: convertedDoc,
        docName: docName,
        dateTime: todaysDateFormatted()));
  }

  void saveEditNote(
      int id, String title, Map<String, dynamic> doc, String createdAt) {
    HiveHabitNotes _note =
        HiveHabitNotes(appflowyDoc: doc, docName: title, dateTime: createdAt);
    print(_notes_database._notesList[id].docName);
    _notes_database._notesList[id][_note];
    /*
    _notes_database._notesList[id].docName = title;
    _notes_database._notesList[id].appflowyDoc = doc;
    _notes_database._notesList[id].dateTime = createdAt;
    */
  }

  void syncNotes() {
    _notes_database.updateData();
    notifyListeners();
  }

  String getJsonNote(String date, int index) {
    _notes_database.getNoteByDate(date, index);
    return _notes_database.toJson();
  }

  List<dynamic> getNoteList() {
    return _notes_database.notesList;
  }
}

final notesDBService = Provider<NotesModel>((_) => NotesModel());

@HiveType(typeId: 1)
class HiveHabitNotes {
  @HiveField(0)
  final String docName;

  @HiveField(1)
  final Map<String, dynamic> appflowyDoc;

  @HiveField(2)
  final String dateTime;

  HiveHabitNotes(
      {required this.appflowyDoc,
      required this.docName,
      required this.dateTime});
}

String notesDBName = 'side_track_notes_hive';
final _notesBox = Hive.box(notesDBName);
const String docList = 'NOTES_LIST';

class NotesModel {
  List _notesList = [];
  List get notesList => _notesList;
  Map<String, dynamic> _appFlowyDoc = {};
  Map<String, dynamic> get appFlowyDoc => _appFlowyDoc;
  String toJson() => jsonEncode(_appFlowyDoc);
  Future<void> prepData() async {
    if (_notesBox.get(docList) == null) {
      createSampleData();
    } else {
      loadData();
    }
    updateData();
  }

  Future<void> createSampleData() async {
    _notesList.addAll(
      [
        HiveHabitNotes(
          appflowyDoc: flowyExample,
          docName: 'Sample Docs',
          dateTime: todaysDateFormatted(),
        ),
        HiveHabitNotes(
          appflowyDoc: flowyExample,
          docName: 'Example File',
          dateTime: todaysDateFormatted(),
        ),
      ],
    );
    _notesBox.put(startDate, todaysDateFormatted());
  }

  void loadData() {
    _notesList = _notesBox.get(docList);
  }

  void updateData() {
    _notesBox.put(todaysDateFormatted(), _notesList);
    _notesBox.put(docList, _notesList);
  }

  Future<void> getNoteByDate(String date, int index) async {
    _notesList.forEach((note) async {
      if (note.dateTime == date) {
        _appFlowyDoc = note.appflowyDoc;
      }
    });
  }
}
