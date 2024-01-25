import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  /// Returns the current user [User].
  Either<AppError, UserEntity> getMyUser();

  /// Starts the Sign In with Google Flow.
  Future<Either<AppError, bool>> loginWithGoogle();

  /// Signs out the current user
  Future<Either<AppError, bool>> logout();
}
