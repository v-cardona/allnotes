part of 'notes_unspecified_cubit.dart';

sealed class NotesUnspecifiedState extends Equatable {
  const NotesUnspecifiedState();

  @override
  List<Object> get props => [];
}

final class NotesUnspecifiedInitial extends NotesUnspecifiedState {}

final class NotesUnspecifiedLoading extends NotesUnspecifiedState {}

final class NotesUnspecifiedLoaded extends NotesUnspecifiedState {
  final List<NoteEntity> notes;

  const NotesUnspecifiedLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesUnspecifiedFailureState extends NotesUnspecifiedState {
  final AppError appError;

  const NotesUnspecifiedFailureState({required this.appError});

  @override
  List<Object> get props => [appError];
}
