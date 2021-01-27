import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final Function onChanged;
  final String labelText;
  final String errorText;

  const PasswordInput(
      {Key key, @required this.onChanged, @required this.errorText, @required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: Colors.deepPurple,
            ),
            labelText: labelText,
            errorText: errorText),
      ),
    );
  }
}
