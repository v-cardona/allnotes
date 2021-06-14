part of 'note_single_bloc.dart';

abstract class NoteSingleState extends Equatable {
  const NoteSingleState();

  @override
  List<Object> get props => [];
}

class NoteSingleInitial extends NoteSingleState {}

class NoteSingleLoading extends NoteSingleState {}

class NoteSingleUpdated extends NoteSingleState {}

class NoteSingleError extends NoteSingleState {
  final AppErrorType appErrorType;

  NoteSingleError({
    @required this.appErrorType,
  });

  @override
  List<Object> get props => [appErrorType];
}
