part of 'edit_note_bloc.dart';

sealed class EditNoteEvent extends Equatable {
  const EditNoteEvent();

  @override
  List<Object> get props => [];
}

class InitEditNoteEvent extends EditNoteEvent {
  const InitEditNoteEvent({
    this.status,
    this.color,
    this.modifiedAt,
  });

  final NoteState? status;
  final Color? color;
  final DateTime? modifiedAt;

  @override
  List<Object> get props => [
        status ?? '',
        color?.value ?? '',
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
