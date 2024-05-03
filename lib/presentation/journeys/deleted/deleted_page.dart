import 'package:allnotes/presentation/journeys/deleted/notes_deleted.dart';
import 'package:flutter/material.dart';

class DeletedPage extends StatelessWidget {
  const DeletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: const [
        NotesDeleted(),
      ],
    );
  }
}
