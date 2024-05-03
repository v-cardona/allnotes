import 'package:allnotes/domain/usecases/notes/get_deleted_notes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/entities/note_entity.dart';

part 'notes_deleted_state.dart';

class NotesDeletedCubit extends Cubit<NotesDeletedState> {
  NotesDeletedCubit({required GetDeletedNotes getDeletedNotes})
      : _getDeletedNotes = getDeletedNotes,
        super(NotesDeletedInitial());

  final GetDeletedNotes _getDeletedNotes;

  Future<void> getAllNotes() async {
    emit(NotesDeletedLoading());
    final response = await _getDeletedNotes(
      NoParams(),
    );

    response.fold(
      (error) => emit(
        NotesDeletedFailureState(appError: error),
      ),
      (notes) => emit(
        NotesDeletedLoaded(notes: notes),
      ),
    );
  }
}
