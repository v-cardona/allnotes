import 'package:allnotes/domain/entities/note_entity.dart';

class AddNoteArguments {
  final NoteEntity note;

  const AddNoteArguments({
    required this.note,
  });
}
