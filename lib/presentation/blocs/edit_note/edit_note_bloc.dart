import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/note_state_entity.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_note_event.dart';
part 'edit_note_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  EditNoteBloc()
      : super(EditNoteState(
          color: AppColor.noteColorDefault,
          status: NoteState.unspecified,
        )) {
    on<InitEditNoteEvent>(
      _initEditNote,
    );
    on<ChangeColorEditNoteEvent>(
      _changeColor,
    );
  }

  /// init bloc
  Future<void> _initEditNote(
    InitEditNoteEvent event,
    Emitter<EditNoteState> emit,
  ) async {
    emit(
      state.copyWith(
        color: event.color,
        status: event.status,
      ),
    );
  }

  /// init bloc
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
}
