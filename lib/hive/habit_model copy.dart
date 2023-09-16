import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/utils.dart';

String dbName = 'hive_side_track';
String currHabitList = 'CURRENT_HABIT_LIST';
String startDate = 'START_DATE';
String percentSummary = 'PERCENTAGE_SUMMARY_${todaysDateFormatted()}';
final _habitBox = Hive.box(dbName);

class HabitModel extends ChangeNotifier {
  List _todaysHabitList = [];
  List get todaysHabitList => _todaysHabitList;
  Map<DateTime, int> _heatMapDataSet = {};
  Map<DateTime, int> get heatMapDataSet => _heatMapDataSet;
  String _startingDate = _habitBox.get(startDate);
  String get startingDate => _startingDate;

  void createSampleData() {
    //NOTE: if theres no habit list create a sample list
    _todaysHabitList.addAll([
      ["Morning Stretches", false],
      ["Lift Weights", false],
      ["Meditate", false]
    ]);

    _habitBox.put(startDate, todaysDateFormatted());
  }

  void loadData() {
    if (_habitBox.get(todaysDateFormatted()) == null) {
      //if its a new day get the habit list then set everything to false
      _todaysHabitList = _habitBox.get(currHabitList);
      for (var idx = 0; idx < _todaysHabitList.length; idx++) {
        _todaysHabitList[idx][1] = false;
      }
    } else {
      //NOTE: If not a new day get todays habit list
      _todaysHabitList = _habitBox.get(todaysDateFormatted());
    }
    notifyListeners();
  }

  void updateData() {
    _habitBox.put(todaysDateFormatted(), _todaysHabitList);
    _habitBox.put(currHabitList, todaysDateFormatted());

    calculateHabitPercentage();
    loadHeatMap();
    notifyListeners();
  }

//NOTE: Calendar Methods
  void calculateHabitPercentage() {
    int completedHabits = 0;
    for (int idx = 0; idx < _todaysHabitList.length; idx++) {
      if (_todaysHabitList[idx][1] == true) {
        completedHabits++;
      }
    }
    String percent = _todaysHabitList.isEmpty
        ? '0.0'
        : (completedHabits / _todaysHabitList.length).toStringAsFixed(1);
    _habitBox.put(percentSummary, percent);
  }

  void loadHeatMap() {
    DateTime habitStartDate = createDateTimeObj(_habitBox.get(startDate));

    int daysInBetween = DateTime.now().difference(habitStartDate).inDays;

    for (int idx = 0; idx < daysInBetween + 1; idx++) {
      String yyyymmdd = convertDateTimeToString(
        habitStartDate.add(Duration(days: idx)),
      );

      double strength = double.parse(_habitBox.get(percentSummary) ?? '0.0');

      int year = habitStartDate.add(Duration(days: idx)).year;
      int month = habitStartDate.add(Duration(days: idx)).month;
      int day = habitStartDate.add(Duration(days: idx)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strength).toInt()
      };
      _heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
