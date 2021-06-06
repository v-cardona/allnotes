import 'package:allnotes/data/core/firestore_client.dart';
import 'package:allnotes/data/data_sources/notes_remote_data_source.dart';
import 'package:allnotes/data/repositories/notes_repository_impl.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/usecases/add_note.dart';
import 'package:allnotes/domain/usecases/get_all_notes.dart';
import 'package:allnotes/domain/usecases/get_user.dart';
import 'package:allnotes/domain/usecases/is_logged.dart';
import 'package:allnotes/domain/usecases/login_with_email.dart';
import 'package:allnotes/domain/usecases/login_with_google.dart';
import 'package:allnotes/domain/usecases/logout.dart';
import 'package:allnotes/domain/usecases/sign_up.dart';
import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:allnotes/presentation/blocs/notes_bloc/notes_bloc.dart';
import 'package:allnotes/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/data/repositories/user_repository_impl.dart';
import 'package:allnotes/domain/repositories/user_repository.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<FirestoreClient>(() => FirestoreClient());
  getItInstance.registerLazySingleton<NotesRemoteDataSource>(
      () => NotesRemoteDataSourceImpl(getItInstance()));

  // user repository
  getItInstance.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()));
  getItInstance.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(getItInstance()));

  // init usecases
  getItInstance.registerLazySingleton<GetUser>(() => GetUser(getItInstance()));
  getItInstance
      .registerLazySingleton<IsLogged>(() => IsLogged(getItInstance()));
  getItInstance.registerLazySingleton<Logout>(() => Logout(getItInstance()));
  getItInstance.registerLazySingleton<LoginWithGoogle>(
      () => LoginWithGoogle(getItInstance()));
  getItInstance.registerLazySingleton<LoginWithEmail>(
      () => LoginWithEmail(getItInstance()));
  getItInstance.registerLazySingleton<SignUp>(() => SignUp(getItInstance()));
  getItInstance
      .registerLazySingleton<GetAllNotes>(() => GetAllNotes(getItInstance()));
  getItInstance.registerLazySingleton<AddNote>(() => AddNote(getItInstance()));

  // blocs
  getItInstance.registerLazySingleton<AuthenticationBloc>(() =>
      AuthenticationBloc(
          getUser: getItInstance(),
          isLogged: getItInstance(),
          logout: getItInstance()));
  getItInstance.registerFactory<LoginBloc>(() => LoginBloc(
      loginWithEmail: getItInstance(), loginWithGoogle: getItInstance()));
  getItInstance
      .registerFactory<SignupBloc>(() => SignupBloc(signUp: getItInstance()));
  getItInstance.registerFactory<NotesBloc>(
      () => NotesBloc(getAllNotes: getItInstance()));
}
