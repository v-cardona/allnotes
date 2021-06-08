import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/presentation/blocs/note_color_bloc/note_color_bloc.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteEditorBottomBar extends StatelessWidget {
  final String strLastModified;

  const NoteEditorBottomBar({
    Key key,
    @required this.strLastModified,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.only(left: Sizes.dimen_10.w),
        child: Row(
          children: [
            Text(strLastModified != null
                ? TranslationConstants.edited.translate(context) +
                    ' $strLastModified'
                : ''),
            Expanded(
              child: Row(),
            ),
            BlocBuilder<NoteColorBloc, NoteColorState>(
              cubit: BlocProvider.of<NoteColorBloc>(context),
              builder: (context, state) {
                if (state is NoteColorChanged) {
                  Color color = state.color;
                  return IconButton(
                    icon: const Icon(Icons.more_vert),
                    color: Colors.black54,
                    onPressed: () => _showNoteBottomSheet(context, color),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNoteBottomSheet(BuildContext context, Color color) {
    showModalBottomSheet(
      context: context,
      backgroundColor: color,
      builder: (_) => Container(
        color: color,
        padding: EdgeInsets.symmetric(vertical: Sizes.dimen_19.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: AppColor.noteColors
                .map(
                  (colorI) => Container(
                    margin: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
                    child: InkWell(
                      child: Container(
                        width: Sizes.dimen_36.w,
                        height: Sizes.dimen_36,
                        decoration: BoxDecoration(
                          color: colorI,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.sharkSemi),
                        ),
                        child: colorI == color
                            ? const Icon(Icons.check, color: AppColor.sharkSemi)
                            : null,
                      ),
                      onTap: () {
                        if (colorI != color) {
                          BlocProvider.of<NoteColorBloc>(context).add(
                            ChangeNoteColorEvent(color: colorI),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
