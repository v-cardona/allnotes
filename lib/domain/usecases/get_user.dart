import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUser {
  final UserRepository userRepository;

  GetUser(this.userRepository);

  User call(NoParams noParams) {
    return userRepository.getUser();
  }
}
