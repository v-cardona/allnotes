part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {

  final bool isSubmitting,
    isSuccess,
    isFailure;

  const LoginState({
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure
  });
  
  @override
  List<Object> get props => [];

  // initial state of the LoginForm
  factory LoginState.empty() {
    return LoginState(
      isFailure: false,
      isSubmitting: false,
      isSuccess: false
    );
  }

  // LoginForm when we are validating credentials
  factory LoginState.loading() {
    return LoginState(
      isFailure: false,
      isSubmitting: true,
      isSuccess: false
    );
  }

  // LoginForm when a login attempt has succeeded
  factory LoginState.success() {
    return LoginState(
      isFailure: false,
      isSubmitting: false,
      isSuccess: true
    );
  }

  // LoginForm when a login attempt has failed
  factory LoginState.failure() {
    return LoginState(
      isFailure: true,
      isSubmitting: false,
      isSuccess: false
    );
  }
}
