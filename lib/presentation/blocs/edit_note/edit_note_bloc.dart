import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/domain/entities/params/note_params.dart';
import 'package:allnotes/domain/usecases/notes/create_note.dart';
import 'package:allnotes/domain/usecases/notes/edit_note.dart';
import 'package:allnotes/presentation/blocs/loading/loading_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_unspecified/notes_unspecified_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/themes/app_color.dart';

part 'edit_note_event.dart';
part 'edit_note_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  EditNoteBloc({
    required LoadingCubit loadingCubit,
    required NotesUnspecifiedCubit notesUnspecifiedCubit,
    required EditNote editNote,
    required CreateNote createNote,
  })  : _editNote = editNote,
        _createNote = createNote,
        _loadingCubit = loadingCubit,
        _notesUnspecifiedCubit = notesUnspecifiedCubit,
        super(EditNoteState(
          color: AppColor.noteColorDefault,
          status: NoteState.unspecified,
        )) {
    on<InitEditNoteEvent>(
      _initEditNote,
    );
    on<ChangeColorEditNoteEvent>(
      _changeColor,
    );
    on<SaveEditNoteEvent>(
      _saveNote,
    );
  }

  final LoadingCubit _loadingCubit;
  final NotesUnspecifiedCubit _notesUnspecifiedCubit;
  final EditNote _editNote;
  final CreateNote _createNote;

  /// init bloc
  Future<void> _initEditNote(
    InitEditNoteEvent event,
    Emitter<EditNoteState> emit,
  ) async {
    emit(
      state.copyWith(
        color: event.color,
        status: event.status,
        id: event.id,
        createdAt: event.createdAt,
      ),
    );
  }

  /// change color note visually
  Future<void> _changeColor(
    ChangeColorEditNoteEvent event,
    Emitter<EditNoteState> emit,
  ) async {
    emit(
      state.copyWith(
        color: event.color,
      ),
    );
  }

  /// save note
  Future<void> _saveNote(
    SaveEditNoteEvent event,
    Emitter<EditNoteState> emit,
  ) async {
    _loadingCubit.show();
    String title =
        event.title != '' ? event.title : TranslationConstants.untitled;
    final note = NoteEntity(
      id: state.id,
      title: title,
      content: event.content,
      color: state.color,
      status: state.status,
      createAt: state.createdAt,
    );
    Either<AppError, bool> response;
    // crear nota nueva
    if (note.id == null) {
      response = await _saveCreateNote(note);
    } else {
      // editar la nota actual
      response = await _saveEditNote(note);
    }

    response.fold(
      (error) => emit(
        state.copyWith(errorType: error.error),
      ),
      (isSaved) {
        if (isSaved) {
          // erload notes list
          _notesUnspecifiedCubit.getAllNotes();
          emit(
            state.copyWith(isSaved: true),
          );
        } else {
          emit(
            state.copyWith(errorType: AppErrorType.defaultError),
          );
        }
      },
    );
    _loadingCubit.hide();
  }

  Future<Either<AppError, bool>> _saveCreateNote(NoteEntity note) async {
    final response = await _createNote(
      NoteParams(note: note),
    );
    return response;
  }

  Future<Either<AppError, bool>> _saveEditNote(NoteEntity note) async {
    final response = await _editNote(
      NoteParams(note: note),
    );
    return response;
  }
}
