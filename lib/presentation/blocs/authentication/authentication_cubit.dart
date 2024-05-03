import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/entities/user_entity.dart';
import 'package:allnotes/domain/usecases/authentication/get_my_user.dart';
import 'package:allnotes/domain/usecases/authentication/login_with_google.dart';
import 'package:allnotes/domain/usecases/authentication/logout.dart';
import 'package:allnotes/domain/usecases/notes/create_first_note.dart';
import 'package:allnotes/presentation/blocs/authentication/authentication_state.dart';
import 'package:allnotes/presentation/blocs/loading/loading_cubit.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required LoadingCubit loadingCubit,
    required LoginWithGoogle loginWithGoogle,
    required Logout logout,
    required GetMyUser getMyUser,
    required CreateFirstNote createFirstNote,
  })  : _loadingCubit = loadingCubit,
        _loginWithGoogle = loginWithGoogle,
        _logout = logout,
        _getMyUser = getMyUser,
        _createFirstNote = createFirstNote,
        super(const AuthenticationState(
          UserEntity.empty,
          AuthenticationEnum.unauthenticated,
        ));

  final LoadingCubit _loadingCubit;
  final LoginWithGoogle _loginWithGoogle;
  final Logout _logout;
  final GetMyUser _getMyUser;
  final CreateFirstNote _createFirstNote;

  // init the subscription to listen the changes of the supabase auth
  // if detects signin or signout will go to the respective page and emit the new state
  StreamSubscription<void> initSubscriptionAuth(BuildContext context) {
    return FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        unauthenticated(context);
      } else {
        authenticated(context);
      }
    });
  }

  // if session exists it means that can authenticate on backend and go to the home page
  // eoc, it will o to the login page and save as unauthenticated
  // it will be handle the splashscreen
  void manageAuth(BuildContext context) {
    getMyUser(context, route: RouteList.rootPage);
  }

  void authenticated(BuildContext context) async {
    _loadingCubit.showInitial();
    getMyUser(context, route: RouteList.rootPage);
    _loadingCubit.hide();
  }

  void unauthenticated(BuildContext context) {
    context.goNamed(RouteList.login);
    emit(const AuthenticationState(
      UserEntity.empty,
      AuthenticationEnum.unauthenticated,
    ));
  }

  void loginWithGoogle() async {
    _loadingCubit.show();
    final response = await _loginWithGoogle(NoParams());
    response.fold(
      (error) => null,
      (userCredential) {
        String? userId = userCredential.user?.uid;
        if ((userCredential.additionalUserInfo?.isNewUser ?? false) &&
            userId != null) {
          _createFirstNote(
            NoParams(),
          );
        }
      },
    );
    _loadingCubit.hide();
  }

  void logout() async {
    _loadingCubit.show();
    await _logout(NoParams());
    _loadingCubit.hide();
  }

  Future<void> getMyUser(
    BuildContext context, {
    /// if authenticated and get user it will go the this route
    String? route,
  }) async {
    final response = await _getMyUser(NoParams());
    response.fold(
      (error) {
        unauthenticated(context);
      },
      (user) {
        if (route != null && route.isNotEmpty) {
          context.goNamed(route);
        }
        emit(AuthenticationState(user, AuthenticationEnum.authenticated));
      },
    );
  }

  void updateUser(UserEntity user) {
    emit(AuthenticationState(user, AuthenticationEnum.authenticated));
  }
}
