import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/entities/user_entity.dart';
import 'package:allnotes/domain/repositories/authentication_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';

class GetMyUser
    extends UseCase<Future<Either<AppError, UserEntity>>, NoParams> {
  final AuthenticationRepository authenticationRepository;

  GetMyUser(this.authenticationRepository);

  @override
  Future<Either<AppError, UserEntity>> call(NoParams params) async {
    return authenticationRepository.getMyUser();
  }
}
