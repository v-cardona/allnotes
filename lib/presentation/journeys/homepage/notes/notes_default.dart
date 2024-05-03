import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/presentation/blocs/notes_unspecified/notes_unspecified_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/common/extensions/error_extension.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/notes_default_grid.dart';
import 'package:allnotes/presentation/journeys/loading/loading_effect.dart';
import 'package:allnotes/presentation/widgets/error_app_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesDefault extends StatelessWidget {
  const NotesDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<NotesUnspecifiedCubit>(),
      builder: (context, state) {
        if (state is NotesUnspecifiedLoading) {
          return Column(
            children: [
              SizedBox(height: Sizes.dimen_230.h),
              const Center(
                child: LoadingEffect(),
              ),
            ],
          );
        } else if (state is NotesUnspecifiedFailureState) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: Sizes.dimen_230.h),
                ErrorAppWidget(
                  errorText: state.appError.getMessage(context),
                ),
              ],
            ),
          );
        } else if (state is NotesUnspecifiedLoaded) {
          return NotesDefaultGrid(
            notes: state.notes,
            title: TranslationConstants.other,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
