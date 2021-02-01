import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';

class SignOut {
  final UserRepository userRepository;

  SignOut(this.userRepository);

  void call(NoParams noParams) {
    userRepository.signOut();
  }
}
