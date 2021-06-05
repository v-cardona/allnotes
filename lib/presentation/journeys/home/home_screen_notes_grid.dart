import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/screenutil/screenutil.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/journeys/home/note_grid_item.dart';
import 'package:flutter/material.dart';

class HomeScreenNotesGrid extends StatelessWidget {
  final List<NoteEntity> notes;

  const HomeScreenNotesGrid({Key key, @required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(Sizes.dimen_10.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: ScreenUtil.defaultWidth / 2,
          mainAxisSpacing: Sizes.dimen_10,
          crossAxisSpacing: Sizes.dimen_10,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => NoteGridItem(
            note: notes[index],
          ),
          childCount: notes.length,
        ),
      ),
    );
  }
}
