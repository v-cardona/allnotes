import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/usecases/get_user.dart';
import 'package:allnotes/domain/usecases/is_logged.dart';
import 'package:allnotes/domain/usecases/logout.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUser getUser;
  final IsLogged isLogged;
  final Logout logout;

  AuthenticationBloc(
      {@required this.getUser, @required this.isLogged, @required this.logout})
      : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      bool isSignedIn = isLogged(NoParams());

      if (isSignedIn) {
        User user = getUser(NoParams());
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    User user = getUser(NoParams());
    yield Authenticated(user);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    logout(NoParams());
    yield Unauthenticated();
  }
}
