import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:allnotes/domain/repositories/user_repository.dart';

/// Thrown if during the sign up process if a failure occurs
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the logout process if a failure occurs
class LogOutFailure implements Exception {}

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
  bool isSignedIn() {
    User currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  /// Starts the Sign In with Google Flow
  /// Throws a [LogInWithGoogleFailure] if an exception occurs
  @override
  Future<User> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _firebaseAuth.signInWithCredential(credential);
      return _firebaseAuth.currentUser;
    } catch (_) {
      throw LogInWithGoogleFailure();
    }
  }

  /// Signs in with the provided [email] and [password]
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs
  @override
  Future<User> signInWithEmail(String email, String password) async {
    assert(email != null && password != null);
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
          return userCredential.user;
    } catch (_) {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user
  /// Throws a [LogOutFailure] if an exception occurs
  @override
  void signOut() async {
    try {
      Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  /// Creates a new user with the provided [email] and [password]
  /// Throws a [SignUpFailure] if an exception occurs
  @override
  Future<User> signUp(String email, String password) async {
    assert(email != null && password != null);
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (_) {
      throw SignUpFailure();
    }
  }
}
