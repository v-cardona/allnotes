import 'package:go_router/go_router.dart';

import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/presentation/journeys/login/login_email_page.dart';
import 'package:allnotes/presentation/journeys/login/login_page.dart';
import 'package:allnotes/presentation/journeys/login/splash_page.dart';
import 'package:allnotes/presentation/journeys/root_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: RouteList.splashPage,
      path: RouteList.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: RouteList.login,
      path: RouteList.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: RouteList.loginEmail,
      path: RouteList.loginEmail,
      builder: (context, state) => const LoginEmailPage(),
    ),
    GoRoute(
      name: RouteList.rootPage,
      path: RouteList.rootPage,
      builder: (context, state) => const RootPage(),
    ),
  ],
);
