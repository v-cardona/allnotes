import 'dart:async';

import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/entities/note_params.dart';
import 'package:allnotes/domain/usecases/add_note.dart';
import 'package:allnotes/domain/usecases/update_note.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'note_single_event.dart';
part 'note_single_state.dart';

class NoteSingleBloc extends Bloc<NoteSingleEvent, NoteSingleState> {
  final AddNote addNote;
  final UpdateNote updateNote;

  NoteSingleBloc({
    @required this.addNote,
    @required this.updateNote,
  }) : super(NoteSingleInitial());

  @override
  Stream<NoteSingleState> mapEventToState(
    NoteSingleEvent event,
  ) async* {
    if (event is SaveNoteSingleEvent) {
      yield NoteSingleLoading();
      if (event.id == null) {
        NoteEntity note = NoteEntity(
          color: event.color,
          state: event.state,
          content: event.content,
          title: event.title,
          id: event.id,
        );
        Either<AppError, bool> eitherAddNote = await addNote.call(
          NoteParams(note: note),
        );
        yield eitherAddNote.fold(
          (l) => NoteSingleError(appErrorType: l.errorType),
          (r) => NoteSingleUpdated(),
        );
      } else {
        NoteEntity note = NoteEntity(
          color: event.color,
          state: event.state,
          content: event.content,
          title: event.title,
          id: event.id,
        );
        Either<AppError, bool> eitherUpdateNote = await updateNote.call(
          NoteParams(note: note),
        );
        yield eitherUpdateNote.fold(
          (l) => NoteSingleError(appErrorType: l.errorType),
          (r) => NoteSingleUpdated(),
        );
      }
    }
  }
}
