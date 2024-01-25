import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/authentication_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';

class LoginWithGoogle
    extends UseCase<Future<Either<AppError, bool>>, NoParams> {
  final AuthenticationRepository authenticationRepository;

  LoginWithGoogle(this.authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(NoParams params) async {
    return await authenticationRepository.loginWithGoogle();
  }
}
