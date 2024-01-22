import 'package:flutter/material.dart';

import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';

class TextPrivacyTerms extends StatelessWidget {
  const TextPrivacyTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      TranslationConstants.termsConditionsAcceptLogin.translate(context),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
