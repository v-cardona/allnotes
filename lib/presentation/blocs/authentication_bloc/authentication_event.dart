part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// event to notify the bloc that it needs to check if the user is currently authenticated or not
class AppStarted extends AuthenticationEvent {}
// event to notify the bloc that the user has successfully logged in
class LoggedIn extends AuthenticationEvent {}
// event to notify the bloc that the user has successfully logged out
class LoggedOut extends AuthenticationEvent {}