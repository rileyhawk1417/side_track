import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/habits/habit_model.dart';

HabitModel _hiveDB = HabitModel();
final box = Hive.box(dbName);

class HabitNotifier extends ChangeNotifier {
  void prepData() {
    if (box.get(currHabitList) == null) {
      _hiveDB.createSampleData();
    } else {
      _hiveDB.loadData();
    }

    _hiveDB.updateData();
    syncData();
  }

  void syncData() {
    _hiveDB.updateData();
    notifyListeners();
  }

  List<dynamic> getHabits() {
    return _hiveDB.todaysHabitList;
  }

  Map<DateTime, int> getHeatMap() {
    return _hiveDB.heatMapDataSet;
  }

  String getStartingDate() {
    return box.get(startDate);
  }
}
