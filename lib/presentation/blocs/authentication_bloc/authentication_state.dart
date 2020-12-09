part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

// waiting to see if the user is authenticated or not on app start.
class Uninitialized extends AuthenticationState {}

// successfully authenticated
class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user);
}

// not authenticated
class Unauthenticated extends AuthenticationState {}
