import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:flutter/material.dart';

class NoteTextInput extends StatelessWidget {
  final bool readOnly;
  final TextEditingController editingController;
  final InputDecoration decoration;
  final int maxLength;
  final TextStyle textStyle;
  final TextInputType keyboardType;

  const NoteTextInput({
    Key key,
    this.readOnly = false,
    @required this.editingController,
    this.decoration,
    this.maxLength,
    this.textStyle,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Sizes.dimen_14.w,
        vertical: Sizes.dimen_8.h,
      ),
      child: TextField(
        controller: editingController,
        keyboardType: keyboardType,
        decoration: decoration,
        maxLines: null,
        maxLength: maxLength,
        style: textStyle,
        textCapitalization: TextCapitalization.sentences,
        readOnly: readOnly,
      ),
    );
  }
}
