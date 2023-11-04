import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:side_track/components/adaptive_text.dart';
import 'package:side_track/hive/habits/habit_model.dart';
import 'package:side_track/hive/notes/notes_function.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _habitList = ref.watch(habitController).getHabitList();
    int _noteLength = ref.watch(notesController).getNumberOfNotes();
    int _habitStreak = ref.watch(habitController).getHabitStreakDays();
    int _completedDailyHabits = 0;
    for (var index in _habitList) {
      if (index[1] == true) {
        _completedDailyHabits++;
      }
    }

    const TextStyle cardTextStyle = TextStyle(color: Colors.white);
    const TextStyle bigText = TextStyle(fontSize: 18);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: Probably add some animation in
          Column(
            children: [
              const Text(
                'Habit Streak',
                style: bigText,
              ),
              Text(
                '${_habitStreak.toString()}/365 days',
                style: bigText,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            color: Theme.of(context).canvasColor,
            child: SizedBox(
              width: 300,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AdaptiveText(
                    text: 'Habits completed today: ',
                    textStyle: cardTextStyle,
                  ),
                  const SizedBox(width: 10.0),
                  AdaptiveText(
                    text: '$_completedDailyHabits/${_habitList.length}',
                    textStyle: cardTextStyle,
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Theme.of(context).canvasColor,
            child: SizedBox(
              width: 300,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AdaptiveText(
                    text: 'Number of notes all time: ',
                    textStyle: cardTextStyle,
                  ),
                  const SizedBox(width: 10.0),
                  AdaptiveText(
                    text: '$_noteLength',
                    textStyle: cardTextStyle,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
