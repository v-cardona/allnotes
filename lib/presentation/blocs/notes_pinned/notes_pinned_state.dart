part of 'notes_pinned_cubit.dart';

sealed class NotesPinnedState extends Equatable {
  const NotesPinnedState();

  @override
  List<Object> get props => [];
}

final class NotesPinnedInitial extends NotesPinnedState {}

final class NotesPinnedLoading extends NotesPinnedState {}

final class NotesPinnedLoaded extends NotesPinnedState {
  final List<NoteEntity> notes;

  const NotesPinnedLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesPinnedFailureState extends NotesPinnedState {
  final AppError appError;

  const NotesPinnedFailureState({required this.appError});

  @override
  List<Object> get props => [appError];
}
