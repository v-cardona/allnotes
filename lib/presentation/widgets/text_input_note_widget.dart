import 'package:flutter/material.dart';

import 'package:allnotes/presentation/widgets/text_input_widget.dart';

class TextInputNoteWidget extends StatelessWidget {
  const TextInputNoteWidget({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.onChange,
    this.suffixIcon,
    this.maxLength,
    this.maxLines,
    this.textStyle,
    this.textInputType = TextInputType.text,
  });

  final String? label;
  final String? hint;
  final Function(String)? onChange;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final int? maxLength;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
      child: TextInputWidget(
        label: label,
        hint: hint,
        controller: controller,
        maxLength: maxLength,
        onChange: onChange,
        textStyle: textStyle,
        maxLines: maxLines,
        textInputType: textInputType,
      ),
    );
  }
}
