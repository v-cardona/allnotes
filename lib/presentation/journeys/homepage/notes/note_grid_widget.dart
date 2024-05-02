import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/presentation/journeys/add_note/add_note_arguments.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/domain/entities/note_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NoteGridWidget extends StatelessWidget {
  const NoteGridWidget({
    super.key,
    required this.note,
  });

  final NoteEntity note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        RouteList.addNotePage,
        extra: AddNoteArguments(note: note),
      ),
      child: Card(
        color: note.color,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_40.w,
            vertical: Sizes.dimen_25.h,
          ),
          child: Column(
            children: [
              Text(
                note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: Sizes.dimen_20.h,
              ),
              Text(
                note.content,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
