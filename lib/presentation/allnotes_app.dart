import 'package:allnotes/presentation/themes/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/languages_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/app_localizations.dart';
import 'package:allnotes/presentation/journeys/loading/loading_page.dart';
import 'package:allnotes/presentation/routes.dart';

class AllnotesApp extends StatefulWidget {
  const AllnotesApp({Key? key}) : super(key: key);

  @override
  State<AllnotesApp> createState() => _AllnotesAppState();
}

class _AllnotesAppState extends State<AllnotesApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // device of moto g5 because of design
      designSize: const Size(1080, 2400),
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
        // builder: (context, child) {
        //   return LoadingPage(
        //     screen: child!,
        //   );
        // },
        routerConfig: router,
      ),
    );
  }
}
