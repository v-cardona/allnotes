import 'dart:async';

import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:allnotes/utils/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  UserRepository userRepository;

  LoginBloc({
    @required this.userRepository
  }) : super(LoginInitial());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(Stream<LoginEvent> events, transitionFn) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) => 
      event is! EmailChanged && event is! PasswordChanged
    );

    //  we give the user some time to stop typing before validating the input
    final debounceStream = observableStream.where((event) => 
      event is EmailChanged || event is PasswordChanged
    ).debounceTime(Duration(milliseconds: 500));

    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(event.email, event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    bool isValid = Validator.isValidEmail(email);
    yield LoginEmailChanged(isValid);
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    bool isValid = Validator.isValidPassword(password);
    yield LoginPasswordChanged(isValid);
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

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(String email, String password) async* {
    yield LoginLoading();
    try {
      await userRepository.signInWithEmail(email, password);
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailure();
    }
  }

}