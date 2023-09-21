import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/hive/notes/notes_function.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _habitList = ref.watch(habitController).getHabitList();
    int _noteLength = ref.watch(notesController).getNumberOfNotes();
    int _completedDailyHabits = 0;
    for (var index in _habitList) {
      if (index[1] == true) {
        _completedDailyHabits++;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Habits completed today: '),
            const SizedBox(width: 10.0),
            Text('$_completedDailyHabits/${_habitList.length}')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Number of notes all time: '),
            const SizedBox(width: 10.0),
            Text('$_noteLength'),
          ],
        )
      ],
    );
  }
}
