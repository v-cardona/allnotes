import 'package:equatable/equatable.dart';

import 'package:allnotes/domain/entities/user_entity.dart';

class AuthenticationState extends Equatable {
  final UserEntity user;
  final AuthenticationEnum authentication;
  const AuthenticationState(this.user, this.authentication);

  @override
  List<Object> get props => [authentication, user];
}

enum AuthenticationEnum { unauthenticated, authenticated }
