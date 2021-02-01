import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithGoogle extends UseCase<User, NoParams> {
  final UserRepository userRepository;

  SignInWithGoogle(this.userRepository);

  @override
  Future<User> call(NoParams noParams) {
    return userRepository.signInWithGoogle();
  }
}
