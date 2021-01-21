part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

// notifies the bloc that the user has changed the email
class EmailChanged extends SignupEvent {
  final String email;

  EmailChanged({@required this.email});
}

// notifies the bloc that the user has changed the password
class PasswordChanged extends SignupEvent {
  final String password;

  PasswordChanged({@required this.password});
}

// notifies the bloc that the user has changed the password confirm
class PasswordConfirmChanged extends SignupEvent {
  final String password;

  PasswordConfirmChanged({@required this.password});
}

// notifies the bloc that the user has pressed the regular signup button
class SignupWithCredentialsPressed extends SignupEvent {
  final Email email;
  final Password password;
  final PasswordConfirm passwordConfirm;

  SignupWithCredentialsPressed({@required this.email, @required this.password, @required this.passwordConfirm});
}
