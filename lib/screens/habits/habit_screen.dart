import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:side_track/hive/habit_functions.dart';
import 'package:side_track/hive/habit_model.dart';
import 'package:side_track/screens/habits/monthly_heatmap.dart';
import 'package:side_track/widgets/habit_box.dart';
import 'package:side_track/widgets/home_screen.dart';

List initList = [
  ["Morning Stretches", false],
  ["Lift Weights", false],
  ["Meditate", false]
];

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreen();
}

class _HabitScreen extends State<HabitScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return Consumer<HabitModel>(builder: (context, habits, __) {
      print(habits.todaysHabitList);
      return Scaffold(
        body: Center(
          child: ListView(
            children: [
              MonthlyHeatMap(
                dataSets: habits.heatMapDataSet,
                startDate: habits.startingDate,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: habits.todaysHabitList.length,
                itemBuilder: (context, index) {
                  var _habitList = habits.todaysHabitList.isNotEmpty
                      ? habits.todaysHabitList
                      : initList;
                  return HabitBox(
                    habitText: _habitList[index][0],
                    habitCompleted: _habitList[index][1],
                    onChanged: (changedValue) =>
                        checkBoxTapped(changedValue, index, context),
                    edit: (context) =>
                        editHabit(context, index, textController),
                    delete: (context) => deleteHabit(index, context),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: HabitFAB(
          clickFunction: () => saveNewHabit(context, textController),
        ),
      );
    });
  }
}
