import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  /// Returns the current user [User].
  Either<AppError, UserEntity> getMyUser();

  /// Starts the Sign In with Google Flow.
  Future<Either<AppError, UserCredential>> loginWithGoogle();

  /// Signs out the current user
  Future<Either<AppError, bool>> logout();
}
