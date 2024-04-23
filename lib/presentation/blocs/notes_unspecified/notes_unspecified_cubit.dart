import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/usecases/notes/get_unspecified_notes.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/entities/params/user_id_param.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_unspecified_state.dart';

class NotesUnspecifiedCubit extends Cubit<NotesUnspecifiedState> {
  NotesUnspecifiedCubit({required GetUnspecifiedNotes getUnspecifiedNotes})
      : _getUnspecifiedNotes = getUnspecifiedNotes,
        super(NotesUnspecifiedInitial());

  final GetUnspecifiedNotes _getUnspecifiedNotes;

  Future<void> getAllNotes() async {
    emit(NotesUnspecifiedLoading());
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final response = await _getUnspecifiedNotes(
      UserIdParams(userId: userId),
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
