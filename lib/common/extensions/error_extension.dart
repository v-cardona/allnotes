import 'package:flutter/material.dart';

import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/domain/entities/app_error_entity.dart';

extension ErrorExtension on AppError {
  String getMessage(BuildContext context) {
    String error;
    switch (this.error) {
      case AppErrorType.cannotCreateCollection:
        error = TranslationConstants.cannotCreateCollection.translate(context);
      case AppErrorType.getAllNotes:
      case AppErrorType.getUnspecifiedNotes:
        error = TranslationConstants.errorGetNotes.translate(context);
      case AppErrorType.cannotEditNote:
        error = TranslationConstants.errorEditNote.translate(context);
      case AppErrorType.cannotCreateNote:
        error = TranslationConstants.errorCreateNote.translate(context);
      case AppErrorType.cannotRemoveNote:
        error = TranslationConstants.errorCreateNote.translate(context);
      default:
        error = TranslationConstants.errorDefault.translate(context);
    }

    return error;
  }

  String defaultError(BuildContext context) {
    return TranslationConstants.errorDefault.translate(context);
  }
}
