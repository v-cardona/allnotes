part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];

}

// initial state of the LoginForm
class LoginInitial extends LoginState {}

// when we are validating credentials
class LoginLoading extends LoginState {}

// when a login attempt has succeeded
class LoginSuccess extends LoginState {}

// when a login attempt has failed
class LoginFailure extends LoginState {}

// when there is a modification on email
class LoginEmailChanged extends LoginState {
  final bool isValidEmail;

  LoginEmailChanged(this.isValidEmail);
}

// when there is a modification on password
class LoginPasswordChanged extends LoginState {
  final bool isValidPassword;

  LoginPasswordChanged(this.isValidPassword);
}

// when submit button will be enable because it has valid format of email and password
class LoginSubmitEnable extends LoginState {}