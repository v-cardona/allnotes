import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';

class Logout {
  final UserRepository userRepository;

  Logout(this.userRepository);

  void call(NoParams noParams) {
    userRepository.logout();
  }
}
