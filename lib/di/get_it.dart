import 'package:allnotes/domain/usecases/get_user.dart';
import 'package:allnotes/domain/usecases/is_sign_in.dart';
import 'package:allnotes/domain/usecases/sign_in_with_email.dart';
import 'package:allnotes/domain/usecases/sign_in_with_google.dart';
import 'package:allnotes/domain/usecases/sign_out.dart';
import 'package:allnotes/domain/usecases/sign_up.dart';
import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:allnotes/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/data/repositories/user_repository_impl.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';

final getItInstance = GetIt.I;

Future init() async {
  // user repository
  getItInstance.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()));

  // init usecases
  getItInstance.registerLazySingleton<GetUser>(() => GetUser(getItInstance()));
  getItInstance
      .registerLazySingleton<IsSignIn>(() => IsSignIn(getItInstance()));
  getItInstance.registerLazySingleton<SignOut>(() => SignOut(getItInstance()));
  getItInstance.registerLazySingleton<SignInWithGoogle>(
      () => SignInWithGoogle(getItInstance()));
  getItInstance.registerLazySingleton<SignInWithEmail>(
      () => SignInWithEmail(getItInstance()));
  getItInstance.registerLazySingleton<SignUp>(() => SignUp(getItInstance()));

  // blocs
  getItInstance.registerLazySingleton<AuthenticationBloc>(() =>
      AuthenticationBloc(
          getUser: getItInstance(),
          isSignIn: getItInstance(),
          signOut: getItInstance()));
  getItInstance.registerFactory<LoginBloc>(() => LoginBloc(
      signInWithEmail: getItInstance(), signInWithGoogle: getItInstance()));
  getItInstance
      .registerFactory<SignupBloc>(() => SignupBloc(signUp: getItInstance()));
}
