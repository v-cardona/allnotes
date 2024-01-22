import 'package:flutter/material.dart';

import 'package:allnotes/common/extensions/string_extensions.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.label,
    required this.controller,
    this.onChange,
    this.onTap,
    this.suffixIcon,
    this.textInputType = TextInputType.name,
    this.maxLength,
  });

  final String label;
  final Function(String)? onChange;
  final Function()? onTap;
  final TextInputType textInputType;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        label: Text(label.translate(context)),
        suffixIcon: Icon(
          suffixIcon,
        ),
      ),
      maxLines: 1,
      onChanged: onChange,
      onTap: onTap,
      maxLength: maxLength,
    );
  }
}
