part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// the user has pressed the Google Sign In button
class LoginWithGooglePressed extends LoginEvent {}