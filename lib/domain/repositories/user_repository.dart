import 'package:firebase_auth/firebase_auth.dart';


abstract class UserRepository {
  User getUser();
  bool isSignedIn();
  Future<User> signInWithGoogle();
  Future<UserCredential> signInWithEmail(String email, String password);
  void signOut();
  Future<UserCredential> signUp(String email, String password);
}