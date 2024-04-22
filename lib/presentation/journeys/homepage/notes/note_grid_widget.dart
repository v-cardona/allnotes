import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/domain/entities/note_entity.dart';

class NoteGridWidget extends StatelessWidget {
  const NoteGridWidget({
    super.key,
    required this.note,
  });

  final NoteEntity note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color,
      child: Padding(
        padding: EdgeInsets.all(Sizes.dimen_10.w),
        child: Column(
          children: [
            Text(
              note.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(note.content),
          ],
        ),
      ),
    );
  }
}
