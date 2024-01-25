import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(HideLoadingState());

  void show() => emit(const ShowLoadingState());

  void showInitial() => emit(const ShowLoadingState(isInitial: true));

  void hide() => emit(HideLoadingState());
}
