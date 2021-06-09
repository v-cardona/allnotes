part of 'note_state_bloc.dart';

abstract class NoteStateEvent extends Equatable {
  const NoteStateEvent();

  @override
  List<Object> get props => [];
}

class ChangeNoteStateEvent extends NoteStateEvent {
  final NoteState state;

  ChangeNoteStateEvent({
    @required this.state,
  });

  @override
  List<Object> get props => [state];
}
