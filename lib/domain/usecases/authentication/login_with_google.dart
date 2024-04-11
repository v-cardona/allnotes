import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/repositories/authentication_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithGoogle
    extends UseCase<Future<Either<AppError, UserCredential>>, NoParams> {
  final AuthenticationRepository authenticationRepository;

  LoginWithGoogle(this.authenticationRepository);

  @override
  Future<Either<AppError, UserCredential>> call(NoParams params) async {
    return await authenticationRepository.loginWithGoogle();
  }
}
