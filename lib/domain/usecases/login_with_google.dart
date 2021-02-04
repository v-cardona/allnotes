import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithGoogle extends UseCase<Either<AppError, User>, NoParams> {
  final UserRepository userRepository;

  LoginWithGoogle(this.userRepository);

  @override
  Future<Either<AppError, User>> call(NoParams noParams) {
    return userRepository.loginWithGoogle();
  }
}
