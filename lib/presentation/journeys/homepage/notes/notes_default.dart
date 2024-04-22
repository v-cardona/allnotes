import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/common/extensions/error_extension.dart';
import 'package:allnotes/presentation/blocs/notes/notes_cubit.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/notes_default_grid.dart';
import 'package:allnotes/presentation/journeys/loading/loading_effect.dart';
import 'package:allnotes/presentation/widgets/error_app_widget.dart';

class NotesDefault extends StatelessWidget {
  const NotesDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<NotesCubit>(),
      builder: (context, state) {
        if (state is NotesLoading) {
          return const Center(
            child: LoadingEffect(),
          );
        } else if (state is NotesFailureState) {
          return ErrorAppWidget(
            errorText: state.appError.getMessage(context),
          );
        } else if (state is NotesLoaded) {
          return NotesDefaultGrid(
            notes: state.notes,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
