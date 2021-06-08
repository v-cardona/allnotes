part of 'note_color_bloc.dart';

abstract class NoteColorEvent extends Equatable {
  const NoteColorEvent();

  @override
  List<Object> get props => [];
}

class ChangeNoteColorEvent extends NoteColorEvent {
  final Color color;

  ChangeNoteColorEvent({
    @required this.color,
  });

  @override
  List<Object> get props => [color];
}
