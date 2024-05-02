import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/note_grid_widget.dart';

class NotesDefaultGrid extends StatelessWidget {
  const NotesDefaultGrid({
    super.key,
    required this.notes,
    this.title,
  });

  final List<NoteEntity> notes;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && notes.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.dimen_40.w,
              ),
              child: Text(
                title!.translate(context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Sizes.dimen_30.w,
              crossAxisSpacing: Sizes.dimen_30.h,
            ),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_20.h,
              horizontal: Sizes.dimen_40.w,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteGridWidget(note: notes[index]);
            },
          ),
        ],
      ),
    );
  }
}
