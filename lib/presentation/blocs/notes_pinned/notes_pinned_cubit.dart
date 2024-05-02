import 'package:allnotes/domain/usecases/notes/get_pinned_notes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/entities/note_entity.dart';

part 'notes_pinned_state.dart';

class NotesPinnedCubit extends Cubit<NotesPinnedState> {
  NotesPinnedCubit({required GetPinnedNotes getPinnedNotes})
      : _getPinnedNotes = getPinnedNotes,
        super(NotesPinnedInitial());

  final GetPinnedNotes _getPinnedNotes;

  Future<void> getAllNotes() async {
    emit(NotesPinnedLoading());
    final response = await _getPinnedNotes(
      NoParams(),
    );

    response.fold(
      (error) => emit(
        NotesPinnedFailureState(appError: error),
      ),
      (notes) => emit(
        NotesPinnedLoaded(notes: notes),
      ),
    );
  }
}
