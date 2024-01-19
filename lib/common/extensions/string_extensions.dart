import 'package:flutter/material.dart';

import 'package:allnotes/presentation/app_localizations.dart';

extension StringExtension on String {
  String translate(BuildContext context) {
    return AppLocalizations.of(context)?.translate(this) ?? '';
  }

  String intelliTrim13() {
    return length > 13 ? '${substring(0, 10)}...' : this;
  }

  String intelliTrim15() {
    return length > 15 ? '${substring(0, 12)}...' : this;
  }

  String intelliTrim18() {
    return length > 18 ? '${substring(0, 15)}...' : this;
  }

  String intelliTrim20() {
    return length > 20 ? '${substring(0, 17)}...' : this;
  }
}
