import 'package:allnotes/common/constants/languages.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/presentation/journeys/home/home_screen.dart';
import 'package:allnotes/presentation/journeys/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/presentation/journeys/login/splashscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

class AllNotesApp extends StatefulWidget {
  // This widget is the root of the application.

  @override
  _AllNotesAppState createState() => _AllNotesAppState();
}

class _AllNotesAppState extends State<AllNotesApp> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = getItInstance<AuthenticationBloc>();
    _authenticationBloc.add(AppStarted());
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: TranslationConstants.app_title,
        supportedLocales:
            Languages.languages.map((e) => Locale(e.code)).toList(),
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        home: BlocProvider.value(
          value: _authenticationBloc,
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              // waiting to see if the user is authenticated or not on app start.
              if (state is Uninitialized) {
                return SplashScreen();
              }

              // successfully authenticated, show home page
              if (state is Authenticated) {
                return HomeScreen();
              }

              // not authenticated, show login page
              return LoginScreen();
            },
          ),
        ));
  }
}
