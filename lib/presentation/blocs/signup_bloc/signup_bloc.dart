import 'dart:async';

import 'package:allnotes/domain/entities/email.dart';
import 'package:allnotes/domain/entities/password.dart';
import 'package:allnotes/domain/entities/password_confirm.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserRepository userRepository;

  SignupBloc({@required this.userRepository}) : super(SignupState());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PasswordConfirmChanged) {
      yield* _mapPasswordConfirmChangedToState(event.password);
    } else if (event is SignupWithCredentialsPressed) {
      yield* _mapSignupWithCredentialsPressedToState(
          event.email, event.password, event.passwordConfirm);
    }
  }

  Stream<SignupState> _mapEmailChangedToState(String value) async* {
    Email email = Email.dirty(value);
    yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password, state.passwordConfirm]));
  }

  Stream<SignupState> _mapPasswordChangedToState(String value) async* {
    Password password = Password.dirty(value);
    yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password, state.passwordConfirm]));
  }

  Stream<SignupState> _mapPasswordConfirmChangedToState(String value) async* {
    PasswordConfirm password = PasswordConfirm.dirty(password: state.password.value, value: value);
    yield state.copyWith(
        passwordConfirm: password,
        status: Formz.validate([state.email, state.password, password]));
  }

  Stream<SignupState> _mapSignupWithCredentialsPressedToState(
      Email email, Password password, PasswordConfirm passwordConfirm) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await userRepository.signUp(email.value, password.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
