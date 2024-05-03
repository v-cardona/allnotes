part of 'notes_deleted_cubit.dart';

sealed class NotesDeletedState extends Equatable {
  const NotesDeletedState();

  @override
  List<Object> get props => [];
}

final class NotesDeletedInitial extends NotesDeletedState {}

final class NotesDeletedLoading extends NotesDeletedState {}

final class NotesDeletedLoaded extends NotesDeletedState {
  final List<NoteEntity> notes;

  const NotesDeletedLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesDeletedFailureState extends NotesDeletedState {
  final AppError appError;

  const NotesDeletedFailureState({required this.appError});

  @override
  List<Object> get props => [appError];
}
