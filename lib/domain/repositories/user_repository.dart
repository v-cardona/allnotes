import 'package:firebase_auth/firebase_auth.dart';


abstract class UserRepository {
  /// Returns the current user log in [User]
  /// Emits [null] if the user is not authenticated.
  User getUser();

  /// Returns true if there is a user log in [Bool]
  /// or false in other case.
  bool isSignedIn();
  
  /// Starts the Sign In with Google Flow.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<User> signInWithGoogle();
  
  /// Signs in with the provided [email] and [password]
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs
  Future<UserCredential> signInWithEmail(String email, String password);

  /// Signs out the current user 
  /// Throws a [LogOutFailure] if an exception occurs
  void signOut();

  /// Creates a new user with the provided [email] and [password]
  /// Throws a [SignUpFailure] if an exception occurs
  Future<UserCredential> signUp(String email, String password);
}