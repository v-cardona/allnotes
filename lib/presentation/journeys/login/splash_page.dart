import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          TranslationConstants.appTitle.translate(context),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => context.go(RouteList.login)),
    );
  }
}
