import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';

class IsSignIn {
  final UserRepository userRepository;

  IsSignIn(this.userRepository);

  bool call(NoParams noParams) {
    return userRepository.isSignedIn();
  }
}
