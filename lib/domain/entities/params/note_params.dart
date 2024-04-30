import 'package:equatable/equatable.dart';

import 'package:allnotes/domain/entities/note_entity.dart';

class NoteParams extends Equatable {
  final NoteEntity note;

  const NoteParams({
    required this.note,
  });

  @override
  List<Object> get props => [note.toString()];
}
