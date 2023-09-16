import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreen();
}

class _NotesScreen extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notes Page'));
  }
}
