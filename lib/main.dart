import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'common/screenutil/screenutil.dart';
import 'di/get_it.dart' as getIt;

import 'package:allnotes/presentation/allnotes_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize dependency injection
  unawaited(getIt.init());
  // load for firebase contents
  await Firebase.initializeApp();
  // Initialize ScreenUtil so that it can use it while defining
  ScreenUtil.init();
  runApp(AllNotesApp());
}