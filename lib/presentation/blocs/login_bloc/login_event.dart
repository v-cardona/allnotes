part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// the user has pressed the Google Sign In button
class LoginWithGooglePressed extends LoginEvent {}

// notifies the bloc that the user has changed the email
class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email});
}

// notifies the bloc that the user has changed the password
class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password});
}

// notifies the bloc that the user has pressed the regular sign in button
class LoginWithCredentialsPressed extends LoginEvent {
  final Email email;
  final Password password;

  LoginWithCredentialsPressed({@required this.email, @required this.password});
}
