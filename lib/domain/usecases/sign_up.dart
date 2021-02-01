import 'package:allnotes/domain/entities/login_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends UseCase<UserCredential, LoginParams> {
  final UserRepository userRepository;

  SignUp(this.userRepository);

  @override
  Future<UserCredential> call(LoginParams loginParams) {
    return userRepository.signUp(loginParams.email, loginParams.password);
  }
}
