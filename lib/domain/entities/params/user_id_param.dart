import 'package:equatable/equatable.dart';

class UserIdParams extends Equatable {
  final String userId;

  const UserIdParams({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
