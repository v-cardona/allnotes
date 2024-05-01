part of 'edit_note_bloc.dart';

sealed class EditNoteEvent extends Equatable {
  const EditNoteEvent();

  @override
  List<Object> get props => [];
}

class InitEditNoteEvent extends EditNoteEvent {
  const InitEditNoteEvent({
    this.id,
    this.status,
    this.color,
    this.modifiedAt,
    this.createdAt,
  });

  final String? id;
  final NoteState? status;
  final Color? color;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  @override
  List<Object> get props => [
        id.toString(),
        status ?? '',
        color?.value ?? '',
        createdAt.toString(),
        modifiedAt.toString(),
      ];
}

class ChangeColorEditNoteEvent extends EditNoteEvent {
  const ChangeColorEditNoteEvent({
    required this.color,
  });

  final Color color;

  @override
  List<Object> get props => [
        color.value,
      ];
}

class SaveEditNoteEvent extends EditNoteEvent {
  const SaveEditNoteEvent({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  List<Object> get props => [
        title,
        content,
      ];
}
