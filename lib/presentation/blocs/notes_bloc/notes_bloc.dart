import 'dart:async';

import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/usecases/get_all_notes.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotes getAllNotes;

  NotesBloc({@required this.getAllNotes}) : super(NotesInitial());

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is NotesLoadEvent) {
      yield NotesLoading();

      final Either<AppError, List<NoteEntity>> eitherResponse =
          await getAllNotes(NoParams());

      yield eitherResponse.fold(
        (l) => NotesError(appErrorType: l.errorType),
        (r) => NotesLoaded(notes: r),
      );
    }
  }
}
