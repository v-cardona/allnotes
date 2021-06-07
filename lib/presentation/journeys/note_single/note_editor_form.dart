import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/data/models/note_model.dart';
import 'package:allnotes/presentation/widgets/note_text_input.dart';
import 'package:allnotes/presentation/widgets/title_text_input.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class NoteEditorForm extends StatelessWidget {
  final NoteModel note;

  const NoteEditorForm({
    Key key,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TitleTextInput(
            initialText: note?.title,
            readOnly: !(note?.canEdit ?? true),
          ),
          SizedBox(
            height: Sizes.dimen_8.h,
          ),
          NoteTextInput(
            initialText: note?.content,
            readOnly: !(note?.canEdit ?? true),
          ),
        ],
      ),
    );
  }
}
