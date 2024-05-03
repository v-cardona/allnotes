import 'package:allnotes/presentation/journeys/archive/notes_archived.dart';
import 'package:flutter/material.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: const [
        NotesArchived(),
      ],
    );
  }
}
