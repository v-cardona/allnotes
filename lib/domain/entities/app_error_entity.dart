import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType _errorType;
  final String _errorCode;

  const AppError(this._errorType, {String errorCode = ''})
      : _errorCode = errorCode;

  @override
  List<Object> get props => [_errorType, _errorCode];

  AppErrorType get error => _errorType;
  String get errorCode => _errorCode;

  factory AppError.defaultError() {
    return const AppError(AppErrorType.defaultError);
  }
}

enum AppErrorType {
  defaultError,
  signupEmailInUse,
  signupEmailInvalid,
  signupWeakPassword,
  loginUserNotFound,
  loginUserDisabled,
  loginWrongPassword,
  loginDifferentCredential,
  firebaseConnection,
  addNoteFailed,
  updateNoteFailed,
}
