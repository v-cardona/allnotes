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

  // --------------
  // REPOSITORIES
  // --------------
  getItInstance.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(),
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
    ),
  );
}
