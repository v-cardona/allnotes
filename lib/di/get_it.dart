import 'package:allnotes/data/core/firebase_client.dart';
import 'package:allnotes/data/data_sources/notes_remote_data_source.dart';
import 'package:allnotes/data/repositories/notes_repository_impl.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/usecases/notes/create_first_note.dart';
import 'package:allnotes/domain/usecases/notes/get_all_notes.dart';
import 'package:allnotes/domain/usecases/notes/get_unspecified_notes.dart';
import 'package:allnotes/presentation/blocs/notes_unspecified/notes_unspecified_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:allnotes/data/repositories/authentication_repository_impl.dart';
import 'package:allnotes/domain/repositories/authentication_repository.dart';
import 'package:allnotes/domain/usecases/authentication/get_my_user.dart';
import 'package:allnotes/domain/usecases/authentication/login_with_google.dart';
import 'package:allnotes/domain/usecases/authentication/logout.dart';
import 'package:allnotes/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:allnotes/presentation/blocs/loading/loading_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  // --------------
  // DATA SOURCES
  // --------------
  getItInstance.registerLazySingleton<FirebaseClient>(
    () => FirebaseClient(),
  );
  getItInstance.registerLazySingleton<NotesRemoteDataSource>(
    () => NotesRemoteDataSourceImpl(
      getItInstance(),
    ),
  );

  // --------------
  // REPOSITORIES
  // --------------
  getItInstance.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(),
  );
  getItInstance.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(
      getItInstance(),
    ),
  );

  // --------------
  // USECASES
  // --------------

  //authentication usecases
  getItInstance.registerLazySingleton<LoginWithGoogle>(
    () => LoginWithGoogle(getItInstance()),
  );
  getItInstance.registerLazySingleton<GetMyUser>(
    () => GetMyUser(getItInstance()),
  );
  getItInstance.registerLazySingleton<Logout>(
    () => Logout(getItInstance()),
  );

  // notes
  getItInstance.registerLazySingleton<CreateFirstNote>(
    () => CreateFirstNote(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<GetAllNotes>(
    () => GetAllNotes(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<GetUnspecifiedNotes>(
    () => GetUnspecifiedNotes(
      getItInstance(),
    ),
  );

  // --------------
  // BLOCS
  // --------------
  // loading
  getItInstance.registerSingleton<LoadingCubit>(
    LoadingCubit(),
  );
  // authentication
  getItInstance.registerSingleton<AuthenticationCubit>(
    AuthenticationCubit(
      loadingCubit: getItInstance(),
      getMyUser: getItInstance(),
      loginWithGoogle: getItInstance(),
      logout: getItInstance(),
      createFirstNote: getItInstance(),
    ),
  );
  // notes
  getItInstance.registerSingleton<NotesUnspecifiedCubit>(
    NotesUnspecifiedCubit(
      getUnspecifiedNotes: getItInstance(),
    ),
  );
}
