import 'package:allnotes/domain/entities/params/note_params.dart';
import 'package:allnotes/domain/usecases/notes/get_deleted_notes.dart';
import 'package:allnotes/domain/usecases/notes/remove_note.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/entities/note_entity.dart';

part 'notes_deleted_state.dart';

class NotesDeletedCubit extends Cubit<NotesDeletedState> {
  NotesDeletedCubit({
    required GetDeletedNotes getDeletedNotes,
    required RemoveNote removeNotes,
  })  : _removeNote = removeNotes,
        _getDeletedNotes = getDeletedNotes,
        super(NotesDeletedInitial());

  final GetDeletedNotes _getDeletedNotes;
  final RemoveNote _removeNote;

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

  Future<void> removeAllNotes() async {
    if (state is NotesDeletedLoaded) {
      List<NoteEntity> notes = state.props[0] as List<NoteEntity>;
      bool hasErrors = false;
      AppError? appError;
      emit(NotesDeletedLoading());
      for (var note in notes) {
        final response = await _removeNote(NoteParams(note: note));
        response.fold(
          (error) {
            hasErrors = true;
            appError = error;
          },
          (isRemoved) {
            if (!isRemoved) {
              hasErrors = true;
            }
          },
        );
      }
      if (hasErrors) {
        emit(
          NotesDeletedFailureState(
            appError: appError ?? const AppError(AppErrorType.cannotRemoveNote),
          ),
        );
      } else {
        emit(NotesDeletedPermanently());
      }

      getAllNotes();
    }
  }
}
