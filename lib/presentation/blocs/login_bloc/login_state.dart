part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];

}

// initial state of the LoginForm
class LoginInitial extends LoginState {}

// LoginForm when we are validating credentials
class LoginLoading extends LoginState {}

// LoginForm when a login attempt has succeeded
class LoginSuccess extends LoginState {}

// LoginForm when a login attempt has failed
class LoginFailure extends LoginState {}