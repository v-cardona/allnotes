import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class NoteEditorBottomBar extends StatelessWidget {
  final String strLastModified;
  final Color color;

  const NoteEditorBottomBar({
    Key key,
    @required this.strLastModified,
    @required this.color,
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
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: Colors.black54,
              onPressed: () => _showNoteBottomSheet(context, color),
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
      builder: (context) => Container(
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
                          print(colorI);
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

// .flatMapIndexed((i, color) => [
//       if (i == 0) const SizedBox(width: 17),
//       InkWell(
//         child: Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             border: Border.all(color: kColorPickerBorderColor),
//           ),
//           child: color == _currColor(note)
//               ? const Icon(Icons.check,
//                   color: kColorPickerBorderColor)
//               : null,
//         ),
//         onTap: () {
//           if (color != _currColor(note)) {
//             note.updateWith(color: color);
//           }
//         },
//       ),
//       SizedBox(width: i == kNoteColors.length - 1 ? 17 : 20),
//     ])
// .asList(),
