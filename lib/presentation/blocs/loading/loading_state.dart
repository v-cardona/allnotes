part of 'loading_cubit.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class HideLoadingState extends LoadingState {}

class ShowLoadingState extends LoadingState {
  // if is initial, it is refer to the loading when login to the backend
  // specially if is starting the server because of sleeping
  final bool isInitial;

  const ShowLoadingState({this.isInitial = false});

  @override
  List<Object> get props => [isInitial];
}
