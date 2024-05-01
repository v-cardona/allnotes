import 'package:allnotes/common/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/languages_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/app_localizations.dart';
import 'package:allnotes/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:allnotes/presentation/blocs/loading/loading_cubit.dart';
import 'package:allnotes/presentation/journeys/loading/loading_page.dart';
import 'package:allnotes/presentation/routes.dart';
import 'package:allnotes/presentation/themes/theme_app.dart';

class AllnotesApp extends StatefulWidget {
  const AllnotesApp({super.key});

  @override
  State<AllnotesApp> createState() => _AllnotesAppState();
}

class _AllnotesAppState extends State<AllnotesApp> {
  late final LoadingCubit _loadingCubit;
  late final AuthenticationCubit _authenticationCubit;

  @override
  void initState() {
    _loadingCubit = getItInstance<LoadingCubit>();
    _authenticationCubit = getItInstance<AuthenticationCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _loadingCubit.close();
    _authenticationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _loadingCubit,
        ),
        BlocProvider(
          create: (context) => _authenticationCubit,
        ),
      ],
      child: ScreenUtilInit(
        // device of moto g5 because of design
        designSize: const Size(Sizes.width_device, Sizes.height_device),
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeApp.lightTheme,
          title: TranslationConstants.appTitle.translate(context),
          supportedLocales:
              Languages.languages.map((e) => Locale(e.code)).toList(),
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return LoadingPage(
              screen: child!,
            );
          },
          routerConfig: router,
        ),
      ),
    );
  }
}
