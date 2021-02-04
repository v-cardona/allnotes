import 'dart:async';

import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/email.dart';
import 'package:allnotes/domain/entities/login_params.dart';
import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/entities/password.dart';
import 'package:allnotes/domain/usecases/login_with_email.dart';
import 'package:allnotes/domain/usecases/login_with_google.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithGoogle loginWithGoogle;
  final LoginWithEmail loginWithEmail;

  LoginBloc({@required this.loginWithGoogle, @required this.loginWithEmail})
      : super(LoginState());

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
    Either<AppError, User> eitherGoogle = await loginWithGoogle(NoParams());
    yield eitherGoogle.fold(
        (l) => state.copyWith(status: FormzStatus.submissionFailure, error: l),
        (r) => state.copyWith(status: FormzStatus.submissionSuccess));
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      Email email, Password password) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      Either<AppError, User> loginEither =
          await loginWithEmail(LoginParams(email.value, password.value));
      yield loginEither.fold(
          (l) =>
              state.copyWith(status: FormzStatus.submissionFailure, error: l),
          (r) => state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}
