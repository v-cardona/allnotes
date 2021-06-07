import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/presentation/themes/theme_text.dart';
import 'package:flutter/material.dart';

class TitleTextInput extends StatelessWidget {
  final String initialText;
  final Function onPressed;
  final bool readOnly;

  const TitleTextInput({
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
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: TranslationConstants.title.translate(context),
          border: InputBorder.none,
          counter: const SizedBox(),
        ),
        maxLines: null,
        maxLength: 1024,
        style: ThemeText.noteEditorTitle,
        textCapitalization: TextCapitalization.sentences,
        readOnly: readOnly,
      ),
    );
  }
}
