import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
/*
class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreen();
}
*/

class HabitScreen extends ConsumerWidget {
  const HabitScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = TextEditingController();
    var _habits = ref.watch(habitController).getHabitList();

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            MonthlyHeatMap(
              dataSets: ref.watch(habitController).getHeatMap(),
              startDate: ref.watch(habitController).getStartingDate(),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                return HabitBox(
                  habitText: _habits[index][0],
                  habitCompleted: _habits[index][1],
                  onChanged: (changedValue) =>
                      checkBoxTapped(changedValue, index, context),
                  edit: (context) => editHabit(context, index, textController),
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
  }
}
