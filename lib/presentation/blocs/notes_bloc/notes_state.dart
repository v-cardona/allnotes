part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesError extends NotesState {
  final AppErrorType appErrorType;

  NotesError({@required this.appErrorType});

  @override
  List<Object> get props => [appErrorType];
}

class NotesLoaded extends NotesState {
  final List<NoteEntity> notes;

  const NotesLoaded({@required this.notes});

  @override
  List<Object> get props => [notes];
}
