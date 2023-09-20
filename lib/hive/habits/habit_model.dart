import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:side_track/hive/utils/date_time.dart';

String dbName = 'side_track_habit_hive';
String habitsDBName = 'hive_side_track';
String currHabitList = 'CURRENT_HABIT_LIST';
String startDate = 'START_DATE';
String percentSummary = 'PERCENTAGE_SUMMARY_${todaysDateFormatted()}';
final _habitBox = Hive.box(dbName);

//NOTE: Riverpod ChangeNotifier for class
final habitController = ChangeNotifierProvider<HabitDBController>((ref) {
  final habitData = ref.watch(habitDBService);
  return HabitDBController(habitData);
});

//NOTE: Jus a controller for state
class HabitDBController extends ChangeNotifier {
  HabitDBController(this._habit_database);
  late final HabitModel _habit_database;

  void onCheckBoxTapped(bool? check, int index) {
    _habit_database.todaysHabitList[index][1] = check;
    notifyListeners();
  }

  void prepData() {
    _habit_database.prepData();
  }

  void reloadData() {
    _habit_database.updateData();
    notifyListeners();
  }

  Map<DateTime, int> getHeatMap() {
    return _habit_database.heatMapDataSet;
  }

  String getStartingDate() {
    return _habit_database.getStartingDate();
  }

  List<dynamic> getHabitList() {
    return _habit_database.todaysHabitList;
  }
}

final habitDBService = Provider<HabitModel>((_) => HabitModel());

class HabitModel {
  List _todaysHabitList = [];
  List get todaysHabitList => _todaysHabitList;
  Map<DateTime, int> _heatMapDataSet = {};
  Map<DateTime, int> get heatMapDataSet => _heatMapDataSet;
  String getStartingDate() {
    return _habitBox.get(startDate);
  }

  Future<void> prepData() async {
    if (_habitBox.get(currHabitList) == null) {
      createSampleData();
    } else {
      loadData();
    }
    updateData();
  }

  void createSampleData() {
    //NOTE: if theres no habit list create a sample list
    _todaysHabitList = [
      ["Morning Stretches", false],
      ["Lift Weights", false],
      ["Meditate", false]
    ];

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

    calculateHabitPercentage();
    loadHeatMap();
  }

  void updateData() {
    _habitBox.put(todaysDateFormatted(), _todaysHabitList);
    _habitBox.put(currHabitList, _todaysHabitList);

    calculateHabitPercentage();
    loadHeatMap();
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
    _habitBox.put('${percentSummary}_${todaysDateFormatted()}', percent);
  }

  void loadHeatMap() {
    DateTime habitStartDate = createDateTimeObj(_habitBox.get(startDate));

    int daysInBetween = DateTime.now().difference(habitStartDate).inDays;

    for (int idx = 0; idx < daysInBetween + 1; idx++) {
      String yyyymmdd = convertDateTimeToString(
        habitStartDate.add(Duration(days: idx)),
      );

      double strength =
          double.parse(_habitBox.get('${percentSummary}_$yyyymmdd') ?? '0.0');

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
