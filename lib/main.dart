import 'package:allnotes/presentation/allnotes_app.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/init_config_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init configure app
  await configureApp();
  // run app
  runApp(const AllnotesApp());
}
