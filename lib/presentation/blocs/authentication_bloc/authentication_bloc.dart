import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/usecases/get_user.dart';
import 'package:allnotes/domain/usecases/is_sign_in.dart';
import 'package:allnotes/domain/usecases/sign_out.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUser getUser;
  final IsSignIn isSignIn;
  final SignOut signOut;

  AuthenticationBloc(
      {@required this.getUser, @required this.isSignIn, @required this.signOut})
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
      bool isSignedIn = isSignIn(NoParams());

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
    signOut(NoParams());
    yield Unauthenticated();
  }
}
