import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/entities/params/user_id_param.dart';
import 'package:allnotes/domain/usecases/notes/get_all_notes.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({required GetAllNotes getAllNotes})
      : _getAllNotes = getAllNotes,
        super(NotesInitial());

  final GetAllNotes _getAllNotes;

  Future<void> getAllNotes() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final response = await _getAllNotes(UserIdParams(userId: userId));

    response.fold(
      (l) => null,
      (notes) => emit(NotesLoaded(notes: notes)),
    );
  }
}
