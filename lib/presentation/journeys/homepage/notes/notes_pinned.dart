import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/presentation/blocs/notes_pinned/notes_pinned_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/common/extensions/error_extension.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/notes_default_grid.dart';
import 'package:allnotes/presentation/journeys/loading/loading_effect.dart';
import 'package:allnotes/presentation/widgets/error_app_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesPinned extends StatelessWidget {
  const NotesPinned({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<NotesPinnedCubit>(),
      builder: (context, state) {
        if (state is NotesPinnedLoading) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: Sizes.dimen_230.h),
                const Center(
                  child: LoadingEffect(),
                ),
              ],
            ),
          );
        } else if (state is NotesPinnedFailureState) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: Sizes.dimen_230.h),
                  ErrorAppWidget(
                    errorText: state.appError.getMessage(context),
                  ),
                ],
              ),
            ),
          );
        } else if (state is NotesPinnedLoaded) {
          return SliverToBoxAdapter(
            child: NotesDefaultGrid(
              notes: state.notes,
              title: TranslationConstants.pinned,
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Container(),
          );
        }
      },
    );
  }
}
