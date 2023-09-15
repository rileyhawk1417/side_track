import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  const DialogBox(
      {super.key,
      required this.cancel,
      required this.save,
      required this.dialogTitle,
      this.editHabitText});

  final void Function() cancel;
  final void Function(String value) save;
  final String dialogTitle;
  final String? editHabitText;
  @override
  State<DialogBox> createState() => _DialogBox();
}

class _DialogBox extends State<DialogBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.editHabitText != null) {
      _controller.text = widget.editHabitText.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.dialogTitle),
      content: TextField(
        controller: _controller,
      ),
      actions: [
        MaterialButton(
            onPressed: () => widget.save(_controller.text),
            child: const Text('Save')),
        MaterialButton(onPressed: widget.cancel, child: const Text('Cancel'))
      ],
    );
  }
}
