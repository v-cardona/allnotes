import 'dart:async';

import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  final UserRepository userRepository;
  
  AuthenticationBloc({
    @required this.userRepository
  }) : super(Uninitialized());

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
      bool isSignedIn = userRepository.isSignedIn();
      
      if (isSignedIn) {
        User user = userRepository.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    User user = userRepository.getUser();
    yield Authenticated(user);
  }
  
  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    userRepository.signOut();
    yield Unauthenticated();
  }

}
