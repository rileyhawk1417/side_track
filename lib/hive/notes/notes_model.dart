import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/notes/sample.dart';
import 'package:side_track/hive/utils/date_time.dart';
part 'notes_model.g.dart';

//NOTE: Since hive doesnt support object storage type adapters are used
@HiveType(typeId: 1)
class HiveHabitNotes {
  @HiveField(0)
  String docName;

  @HiveField(1)
  Map<String, dynamic> appflowyDoc;

  @HiveField(2)
  String dateTime;

  HiveHabitNotes(
      {required this.appflowyDoc,
      required this.docName,
      required this.dateTime});
}

String notesDBName = 'side_track_notes_hive';
const String docList = 'NOTES_LIST';

class NotesModel {
  //NOTE: Specify the type of box we are using
  final _notesBox = Hive.box<HiveHabitNotes>(notesDBName);
  Box<HiveHabitNotes> get notesBox => _notesBox;
  Future<void> prepData() async {
    if (_notesBox.keys.isEmpty) {
      createSampleData();
    } else {
      loadNoteKeys();
    }
  }

  Future<void> createSampleData() async {
    HiveHabitNotes note_1 = HiveHabitNotes(
      appflowyDoc: flowyExample,
      docName: 'Sample Docs',
      dateTime: todaysDateFormatted(),
    );

    HiveHabitNotes note_2 = HiveHabitNotes(
      appflowyDoc: flowyExample,
      docName: 'Example Note',
      dateTime: todaysDateFormatted(),
    );
    _notesBox.add(note_1);
    _notesBox.add(note_2);
  }

  List<int> loadNoteKeys() {
    return _notesBox.keys.cast<int>().toList();
  }

  void addNewNote(HiveHabitNotes newNote) {
    //NOTE: Using add enables auto-increment
    _notesBox.add(newNote);
  }

  void deleteNote(int noteIndex) {
    _notesBox.deleteAt(noteIndex);
  }

//TODO: Search notes by title function
  HiveHabitNotes? getNoteByDate(String noteTitle, int index) {
    HiveHabitNotes? searchedTitle;
    _notesBox.values.where((note) {
      if (note.docName == noteTitle) {
        searchedTitle = note;
        return true;
      }
      return false;
    });
    return searchedTitle;
  }
}
