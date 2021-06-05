import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

/// A single item (preview of a Note) in the Notes grid.
class NoteGridItem extends StatelessWidget {
  final NoteEntity note;

  const NoteGridItem({
    Key key,
    this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.all(Radius.circular(
            Sizes.dimen_8,
          )),
          border: Border.all(
            color: AppColor.iron,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (note.title?.isNotEmpty)
              Text(
                note.title,
                maxLines: 1,
              ),
            if (note.title?.isNotEmpty)
              SizedBox(
                height: Sizes.dimen_8.h,
              ),
            Flexible(
              flex: 1,
              child: Text(note.content ??
                  ''), // wrapping using a Flexible to avoid overflow
            ),
          ],
        ),
      );
}
