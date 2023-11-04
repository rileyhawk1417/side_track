import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/hive/habits/habit_functions.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/screens/habits/monthly_heatmap.dart';
import 'package:side_track/widgets/habit_box.dart';
import 'package:side_track/widgets/navigation.dart';

class VisitHabitScreen extends ConsumerWidget {
  const VisitHabitScreen(
      {super.key, required this.selectedDate, required this.formattedDate});
  final String selectedDate;
  final String formattedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = TextEditingController();
    var _habits = ref.watch(habitController).fetchHabit(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Habits for: $formattedDate ',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            //BUG: Fails to find habits then fetches them!
            _habits.isEmpty
                ? Center(child: Text('No habits found on: $formattedDate'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _habits.length,
                    itemBuilder: (context, index) {
                      return HabitBox(
                        habitText: _habits[index][0],
                        habitCompleted: _habits[index][1],
                        index: index,
                        date: selectedDate,
                        edit: (context) =>
                            editHabit(context, index, textController, ref),
                        delete: (context) => deleteHabit(index, context, ref),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
