import 'package:allnotes/presentation/journeys/homepage/notes/notes_pinned.dart';
import 'package:flutter/material.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/notes_default.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: const [
        NotesPinned(),
        NotesDefault(),
      ],
    );
  }
}
