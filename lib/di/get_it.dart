import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/data/repositories/user_repository_impl.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';

final getItInstance = GetIt.I;


Future init() async {
  // user repository
  getItInstance.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn()
    )
  );

  // blocs
  getItInstance.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(userRepository: getItInstance())
  );
  getItInstance.registerFactory<LoginBloc>(
    () => LoginBloc(userRepository: getItInstance())
  );

}