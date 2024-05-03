import 'package:allnotes/domain/usecases/notes/get_archived_notes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/entities/note_entity.dart';

part 'notes_archived_state.dart';

class NotesArchivedCubit extends Cubit<NotesArchivedState> {
  NotesArchivedCubit({required GetArchivedNotes getArchivedNotes})
      : _getArchivedNotes = getArchivedNotes,
        super(NotesArchivedInitial());

  final GetArchivedNotes _getArchivedNotes;

  Future<void> getAllNotes() async {
    emit(NotesArchivedLoading());
    final response = await _getArchivedNotes(
      NoParams(),
    );

    response.fold(
      (error) => emit(
        NotesArchivedFailureState(appError: error),
      ),
      (notes) => emit(
        NotesArchivedLoaded(notes: notes),
      ),
    );
  }
}
