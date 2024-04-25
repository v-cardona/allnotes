import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/common/extensions/string_extensions.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.controller,
    this.label,
    this.onChange,
    this.onTap,
    this.suffixIcon,
    this.textInputType = TextInputType.name,
    this.maxLength,
    this.maxLines = 1,
    this.textStyle,
    this.hint,
  });

  final String? label;
  final String? hint;
  final Function(String)? onChange;
  final Function()? onTap;
  final TextInputType textInputType;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final int? maxLength;
  final int? maxLines;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: controller,
      keyboardType: textInputType,
      style: textStyle,
      decoration: InputDecoration(
        counter: Container(),
        hintText: hint,
        label: label != null ? Text(label!.translate(context)) : null,
        suffixIcon: Icon(
          suffixIcon,
          color: AppColor.amber,
        ),
      ),
      maxLines: maxLines,
      onChanged: onChange,
      onTap: onTap,
      maxLength: maxLength,
    );
  }
}
