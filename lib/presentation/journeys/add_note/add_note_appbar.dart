import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/blocs/edit_note/edit_note_bloc.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:allnotes/presentation/widgets/color_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddNoteAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AddNoteAppbar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditNoteBloc, EditNoteState>(
      bloc: context.read<EditNoteBloc>(),
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: state.color,
            ),
          ),
          child: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.push_pin_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.archive_outlined),
              ),
              IconButton(
                onPressed: () => _openBottomSheetOptions(context),
                icon: const Icon(Icons.more_vert_outlined),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openBottomSheetOptions(BuildContext context) {
    Color color = context.read<EditNoteBloc>().state.color;

    showModalBottomSheet(
      context: context,
      backgroundColor: color,
      builder: (contextBuilderSheet) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline_outlined),
              title: Text(
                TranslationConstants.delete.translate(context),
              ),
              onTap: () {},
            ),
            const Divider(),
            SizedBox(
              height: Sizes.dimen_200.h,
              child: ListView.builder(
                itemCount: AppColor.noteColors.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (contextItemBuilder, index) {
                  EdgeInsetsGeometry padding = EdgeInsets.only(
                    right: Sizes.dimen_20.w,
                  );
                  if (index == 0) {
                    padding = EdgeInsets.only(
                      left: Sizes.dimen_20.w,
                      right: Sizes.dimen_20.w,
                    );
                  }
                  return Padding(
                    padding: padding,
                    child: GestureDetector(
                      onTap: () {
                        context.read<EditNoteBloc>().add(
                              ChangeColorEditNoteEvent(
                                color: AppColor.noteColors.elementAt(index),
                              ),
                            );
                        context.pop();
                      },
                      child: ColorPickerWidget(
                        color: AppColor.noteColors.elementAt(index),
                        selected: AppColor.noteColors.elementAt(index) == color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
