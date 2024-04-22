import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/note_grid_widget.dart';

class NotesDefaultGrid extends StatelessWidget {
  const NotesDefaultGrid({
    super.key,
    required this.notes,
  });

  final List<NoteEntity> notes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Sizes.dimen_30.w,
          crossAxisSpacing: Sizes.dimen_30.h,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Sizes.dimen_230.h,
          horizontal: Sizes.dimen_40.w,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteGridWidget(note: notes[index]);
        },
      ),
    );
  }
}
