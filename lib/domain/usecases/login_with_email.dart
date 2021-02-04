import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/login_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithEmail extends UseCase<Either<AppError, User>, LoginParams> {
  final UserRepository userRepository;

  LoginWithEmail(this.userRepository);

  @override
  Future<Either<AppError, User>> call(LoginParams loginParams) {
    return userRepository.loginWithEmail(loginParams.email, loginParams.password);
  }
}
