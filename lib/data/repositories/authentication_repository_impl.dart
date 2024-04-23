import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/user_entity.dart';
import 'package:allnotes/domain/repositories/authentication_repository.dart';

/// Repository which manages authentication
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl()
      : _firebaseAuth = firebase_auth.FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn(scopes: ['email']);

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// returns de id of the logged user
  /// empty string eoc
  @override
  String getUserId() {
    return _firebaseAuth.currentUser?.uid ?? '';
  }

  /// Returns the current user.
  /// Defaults to [User.empty] if there is no user.
  @override
  Either<AppError, UserEntity> getMyUser() {
    firebase_auth.User? userFirebase = _firebaseAuth.currentUser;
    if (userFirebase != null) {
      return Right(userFirebase.toUser);
    } else {
      return const Left(AppError(AppErrorType.userNotFound));
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  @override
  Future<Either<AppError, UserCredential>> loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return Right(userCredential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      AppError appError = getErrorFromFirebaseCode(e.code);
      return Left(appError);
    } catch (_) {
      return const Left(AppError(AppErrorType.defaultError));
    }
  }

  /// Signs out the current user
  @override
  Future<Either<AppError, bool>> logout() async {
    try {
      Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return const Right(true);
    } catch (_) {
      return const Left(AppError(AppErrorType.logout));
    }
  }

  /// Returns [AppError] from firebase code
  AppError getErrorFromFirebaseCode(String code) {
    AppErrorType appErrorType = AppErrorType.defaultError;
    switch (code) {
      case 'account-exists-with-different-credential':
        appErrorType = AppErrorType.accountExists;
        break;
      case 'invalid-credential':
        appErrorType = AppErrorType.invalidCredential;
        break;
      case 'operation-not-allowed':
        appErrorType = AppErrorType.operationNotAllowed;
        break;
      case 'user-disabled':
        appErrorType = AppErrorType.userDisabled;
        break;
      case 'user-not-found':
        appErrorType = AppErrorType.userNotFound;
        break;
      case 'wrong-password':
        appErrorType = AppErrorType.invalidCredential;
        break;
      case 'invalid-verification-code':
        appErrorType = AppErrorType.invalidVerificationCode;
        break;
      case 'invalid-verification-id':
        appErrorType = AppErrorType.invalidVerificationId;
        break;
      default:
        appErrorType = AppErrorType.defaultError;
    }

    return AppError(appErrorType);
  }
}

extension on firebase_auth.User {
  UserEntity get toUser {
    return UserEntity(
        id: uid, email: email, name: displayName, photo: photoURL);
  }
}
