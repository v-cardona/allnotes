import 'package:allnotes/data/core/firebase_client.dart';
import 'package:allnotes/data/data_sources/notes_remote_data_source.dart';
import 'package:allnotes/data/repositories/notes_repository_impl.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/usecases/notes/create_first_note.dart';
import 'package:allnotes/domain/usecases/notes/create_note.dart';
import 'package:allnotes/domain/usecases/notes/edit_note.dart';
import 'package:allnotes/domain/usecases/notes/get_all_notes.dart';
import 'package:allnotes/domain/usecases/notes/get_archived_notes.dart';
import 'package:allnotes/domain/usecases/notes/get_deleted_notes.dart';
import 'package:allnotes/domain/usecases/notes/get_pinned_notes.dart';
import 'package:allnotes/domain/usecases/notes/get_unspecified_notes.dart';
import 'package:allnotes/presentation/blocs/edit_note/edit_note_bloc.dart';
import 'package:allnotes/presentation/blocs/navigation_drawer/navigation_drawer_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_archived/notes_archived_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_pinned/notes_pinned_cubit.dart';
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
  getItInstance.registerLazySingleton<EditNote>(
    () => EditNote(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<CreateNote>(
    () => CreateNote(
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
  getItInstance.registerLazySingleton<GetPinnedNotes>(
    () => GetPinnedNotes(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<GetArchivedNotes>(
    () => GetArchivedNotes(
      getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<GetDeletedNotes>(
    () => GetDeletedNotes(
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
  getItInstance.registerFactory(
    () => NavigationDrawerCubit(),
  );
  // notes
  getItInstance.registerSingleton<NotesUnspecifiedCubit>(
    NotesUnspecifiedCubit(
      getUnspecifiedNotes: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<NotesPinnedCubit>(
    NotesPinnedCubit(
      getPinnedNotes: getItInstance(),
    ),
  );
  getItInstance.registerSingleton<NotesArchivedCubit>(
    NotesArchivedCubit(
      getArchivedNotes: getItInstance(),
    ),
  );
  // edit/create note
  getItInstance.registerFactory(
    () => EditNoteBloc(
      createNote: getItInstance(),
      editNote: getItInstance(),
      loadingCubit: getItInstance(),
      notesUnspecifiedCubit: getItInstance(),
      notesPinnedCubit: getItInstance(),
      notesArchivedCubit: getItInstance(),
    ),
  );
}
