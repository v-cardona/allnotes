import 'dart:async';

import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:allnotes/di/get_it.dart' as get_it;

Future<void> configureApp() async {
  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize dependency injection
  await get_it.init();

  // force to portrait mode only
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
}
