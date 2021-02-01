import 'dart:async';

import 'package:allnotes/domain/entities/email.dart';
import 'package:allnotes/domain/entities/login_params.dart';
import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/entities/password.dart';
import 'package:allnotes/domain/usecases/sign_in_with_email.dart';
import 'package:allnotes/domain/usecases/sign_in_with_google.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmail signInWithEmail;

  LoginBloc({@required this.signInWithGoogle, @required this.signInWithEmail}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          event.email, event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String value) async* {
    Email email = Email.dirty(value);
    yield state.copyWith(
        email: email, status: Formz.validate([email, state.password]));
  }

  Stream<LoginState> _mapPasswordChangedToState(String value) async* {
    Password password = Password.dirty(value);
    yield state.copyWith(
        password: password, status: Formz.validate([state.email, password]));
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      await signInWithGoogle(NoParams());
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    } catch (_) {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      Email email, Password password) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await signInWithEmail(LoginParams(email.value, password.value));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
