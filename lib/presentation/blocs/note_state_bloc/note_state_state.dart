part of 'note_state_bloc.dart';

abstract class NoteStateState extends Equatable {
  const NoteStateState();

  @override
  List<Object> get props => [];
}

class NoteStateInitial extends NoteStateState {}

class NoteStateChanging extends NoteStateState {}

class NoteStateChanged extends NoteStateState {
  final NoteState state;

  NoteStateChanged({
    this.state,
  });

  @override
  List<Object> get props => [state];
}
