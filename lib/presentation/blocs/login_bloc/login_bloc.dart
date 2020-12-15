import 'dart:async';

import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  UserRepository userRepository;

  LoginBloc({
    @required this.userRepository
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield LoginLoading();
    try {
      await userRepository.signInWithGoogle();
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailure();
    }
  }
}
