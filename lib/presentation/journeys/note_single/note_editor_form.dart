import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/presentation/themes/theme_text.dart';
import 'package:allnotes/presentation/widgets/note_text_input.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class NoteEditorForm extends StatelessWidget {
  final bool readOnly;
  final TextEditingController noteTitleController;
  final TextEditingController noteContentController;

  const NoteEditorForm({
    Key key,
    this.readOnly,
    @required this.noteTitleController,
    @required this.noteContentController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          NoteTextInput(
            editingController: noteTitleController,
            decoration: InputDecoration(
              hintText: TranslationConstants.title.translate(context),
              border: InputBorder.none,
              counter: const SizedBox(),
            ),
            maxLength: 1024,
            textStyle: ThemeText.noteEditorTitle,
            readOnly: readOnly,
          ),
          SizedBox(
            height: Sizes.dimen_8.h,
          ),
          NoteTextInput(
            editingController: noteContentController,
            decoration: InputDecoration.collapsed(
              hintText: TranslationConstants.note.translate(context),
            ),
            textStyle: ThemeText.noteEditor,
            keyboardType: TextInputType.multiline,
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}
