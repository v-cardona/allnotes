import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/presentation/themes/theme_text.dart';
import 'package:flutter/material.dart';

class NoteTextInput extends StatelessWidget {
  final String initialText;
  final Function onPressed;
  final bool readOnly;

  const NoteTextInput({
    Key key,
    this.initialText = '',
    this.onPressed,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Sizes.dimen_14.w,
        vertical: Sizes.dimen_8.h,
      ),
      child: TextFormField(
        initialValue: initialText,
        onChanged: onPressed,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration.collapsed(
          hintText: TranslationConstants.note.translate(context),
        ),
        maxLines: null,
        style: ThemeText.noteEditor,
        textCapitalization: TextCapitalization.sentences,
        readOnly: readOnly,
      ),
    );
  }
}
