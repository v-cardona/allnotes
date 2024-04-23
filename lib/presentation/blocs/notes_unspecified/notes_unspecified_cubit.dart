import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/usecases/notes/get_unspecified_notes.dart';
import 'package:allnotes/domain/entities/note_entity.dart';

part 'notes_unspecified_state.dart';

class NotesUnspecifiedCubit extends Cubit<NotesUnspecifiedState> {
  NotesUnspecifiedCubit({required GetUnspecifiedNotes getUnspecifiedNotes})
      : _getUnspecifiedNotes = getUnspecifiedNotes,
        super(NotesUnspecifiedInitial());

  final GetUnspecifiedNotes _getUnspecifiedNotes;

  Future<void> getAllNotes() async {
    emit(NotesUnspecifiedLoading());
    final response = await _getUnspecifiedNotes(
      NoParams(),
    );

    response.fold(
      (error) => emit(
        NotesUnspecifiedFailureState(appError: error),
      ),
      (notes) => emit(
        NotesUnspecifiedLoaded(notes: notes),
      ),
    );
  }
}
