part of 'signup_bloc.dart';

// initial state and manage email and password
class SignupState extends Equatable {

  final Email email;
  final Password password;
  final PasswordConfirm passwordConfirm;
  final FormzStatus status;
  final AppError error;

  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordConfirm = const PasswordConfirm.pure(),
    this.status = FormzStatus.pure,
    this.error
  });

  @override
  List<Object> get props => [email, password, passwordConfirm, status, error];

  SignupState copyWith({
    Email email,
    Password password,
    PasswordConfirm passwordConfirm,
    FormzStatus status,
    AppError error
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }
}