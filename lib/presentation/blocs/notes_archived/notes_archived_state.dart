part of 'notes_archived_cubit.dart';

sealed class NotesArchivedState extends Equatable {
  const NotesArchivedState();

  @override
  List<Object> get props => [];
}

final class NotesArchivedInitial extends NotesArchivedState {}

final class NotesArchivedLoading extends NotesArchivedState {}

final class NotesArchivedLoaded extends NotesArchivedState {
  final List<NoteEntity> notes;

  const NotesArchivedLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesArchivedFailureState extends NotesArchivedState {
  final AppError appError;

  const NotesArchivedFailureState({required this.appError});

  @override
  List<Object> get props => [appError];
}
