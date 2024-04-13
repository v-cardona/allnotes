part of 'notes_cubit.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<NoteEntity> notes;

  const NotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}
