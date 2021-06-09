import 'dart:async';

import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'note_state_event.dart';
part 'note_state_state.dart';

class NoteStateBloc extends Bloc<NoteStateEvent, NoteStateState> {
  NoteStateBloc() : super(NoteStateInitial());

  @override
  Stream<NoteStateState> mapEventToState(
    NoteStateEvent event,
  ) async* {
    yield NoteStateChanging();
    if (event is ChangeNoteStateEvent) {
      yield NoteStateChanged(
        state: event.state,
      );
    }
  }
}
