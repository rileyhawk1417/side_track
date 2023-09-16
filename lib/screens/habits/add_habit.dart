import 'package:flutter/material.dart';

class AddHabit extends StatelessWidget {
  const AddHabit(
      {super.key,
      required this.cancel,
      required this.textController,
      required this.save});
  final void Function() cancel;
  final void Function() save;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Habit'),
      content: TextField(
        controller: textController,
      ),
      actions: [
        MaterialButton(onPressed: save, child: const Text('Save')),
        MaterialButton(onPressed: cancel, child: const Text('Cancel'))
      ],
    );
  }
}
