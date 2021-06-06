import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:equatable/equatable.dart';

class NoteParams extends Equatable {
  final NoteEntity note;

  NoteParams(this.note);

  @override
  List<Object> get props => [note];
}
