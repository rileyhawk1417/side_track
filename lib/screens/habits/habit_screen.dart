import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/hive/habits/habit_functions.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/screens/habits/monthly_heatmap.dart';
import 'package:side_track/widgets/habit_box.dart';
import 'package:side_track/widgets/navigation.dart';

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
                      checkBoxTapped(changedValue, index, ref),
                  edit: (context) =>
                      editHabit(context, index, textController, ref),
                  delete: (context) => deleteHabit(index, context, ref),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: HabitFAB(
        clickFunction: () => saveNewHabit(context, textController, ref),
      ),
    );
  }
}
