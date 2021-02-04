import 'package:allnotes/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:allnotes/domain/repositories/user_repository.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication
/// {@endtemplate}
class UserRepositoryImpl extends UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// {@macro authentication_repository}
  UserRepositoryImpl({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  /// Returns the current user log in [User]
  /// Emits [null] if the user is not authenticated
  @override
  User getUser() {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  /// Returns true if there is a user log in [Bool]
  /// or false in other case
  @override
  bool isLogged() {
    User currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  /// Starts the Sign In with Google Flow
  /// Throws a [LogInWithGoogleFailure] if an exception occurs
  @override
  Future<Either<AppError, User>> loginWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _firebaseAuth.signInWithCredential(credential);
      return Right(_firebaseAuth.currentUser);
    } on FirebaseAuthException catch (e) {
      AppErrorType errorType = AppErrorType.general;
      if (e.code == 'user-not-found') {
        errorType = AppErrorType.loginUserNotFound;
      } else if (e.code == 'user-disabled') {
        errorType = AppErrorType.loginUserDisabled;
      } else if (e.code == 'account-exists-with-different-credential') {
        errorType = AppErrorType.loginDifferentCredential;
      } else if (e.code == 'wrong-password') {
        errorType = AppErrorType.loginWrongPassword;
      }
      return Left(AppError(errorType));
    } catch (_) {
      return Left(AppError(AppErrorType.general));
    }
  }

  /// Signs in with the provided [email] and [password]
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs
  @override
  Future<Either<AppError, User>> loginWithEmail(
      String email, String password) async {
    assert(email != null && password != null);
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      AppErrorType errorType = AppErrorType.general;
      if (e.code == 'user-not-found') {
        errorType = AppErrorType.loginUserNotFound;
      } else if (e.code == 'user-disabled') {
        errorType = AppErrorType.loginUserDisabled;
      } else if (e.code == 'invalid-email') {
        errorType = AppErrorType.signupEmailInvalid;
      } else if (e.code == 'wrong-password') {
        errorType = AppErrorType.loginWrongPassword;
      }
      return Left(AppError(errorType));
    } catch (_) {
      return Left(AppError(AppErrorType.general));
    }
  }

  /// Signs out the current user
  /// Throws a [LogOutFailure] if an exception occurs
  @override
  void logout() async {
    Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  /// Creates a new user with the provided [email] and [password]
  /// Throws a [SignUpFailure] if an exception occurs
  @override
  Future<Either<AppError, User>> signUp(String email, String password) async {
    assert(email != null && password != null);
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      AppErrorType errorType = AppErrorType.general;
      if (e.code == 'weak-password') {
        errorType = AppErrorType.signupWeakPassword;
      } else if (e.code == 'email-already-in-use') {
        errorType = AppErrorType.signupEmailInUse;
      } else if (e.code == 'invalid-email') {
        errorType = AppErrorType.signupEmailInvalid;
      }
      return Left(AppError(errorType));
    } catch (_) {
      return Left(AppError(AppErrorType.general));
    }
  }
}
