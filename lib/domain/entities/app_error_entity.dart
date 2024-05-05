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
  accountExists,
  invalidCredential,
  operationNotAllowed,
  userDisabled,
  userNotFound,
  invalidVerificationCode,
  invalidVerificationId,
  logout,
  cannotCreateCollection,
  cannotEditNote,
  cannotRemoveNote,
  cannotCreateNote,
  getAllNotes,
  getUnspecifiedNotes,
}
