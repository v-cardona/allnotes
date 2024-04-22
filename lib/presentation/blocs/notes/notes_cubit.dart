import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/entities/params/user_id_param.dart';
import 'package:allnotes/domain/usecases/notes/get_all_notes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({required GetAllNotes getAllNotes})
      : _getAllNotes = getAllNotes,
        super(NotesInitial());

  final GetAllNotes _getAllNotes;

  Future<void> getAllNotes() async {
    emit(NotesLoading());
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final response = await _getAllNotes(
      UserIdParams(userId: userId),
    );

    response.fold(
      (error) => emit(
        NotesFailureState(appError: error),
      ),
      (notes) => emit(
        NotesLoaded(notes: notes),
      ),
    );
  }
}
