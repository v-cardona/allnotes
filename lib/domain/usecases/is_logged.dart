import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';

class IsLogged {
  final UserRepository userRepository;

  IsLogged(this.userRepository);

  bool call(NoParams noParams) {
    return userRepository.isLogged();
  }
}
