import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NoteParams extends Equatable {
  final NoteEntity note;

  NoteParams({
    @required this.note,
  });

  @override
  List<Object> get props => [note];
}
