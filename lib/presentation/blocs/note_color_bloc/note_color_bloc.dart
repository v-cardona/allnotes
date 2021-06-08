import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'note_color_event.dart';
part 'note_color_state.dart';

class NoteColorBloc extends Bloc<NoteColorEvent, NoteColorState> {
  NoteColorBloc() : super(NoteColorInitial());

  @override
  Stream<NoteColorState> mapEventToState(
    NoteColorEvent event,
  ) async* {
    yield NoteColorChanging();
    if (event is ChangeNoteColorEvent) {
      yield NoteColorChanged(
        color: event.color,
      );
    }
  }
}
