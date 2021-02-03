import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final Function onChanged;
  final String labelText;
  final String errorText;

  const PasswordInput(
      {Key key,
      @required this.onChanged,
      @required this.errorText,
      @required this.labelText})
      : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
      child: TextField(
        onChanged: widget.onChanged,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _isPasswordHidden,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: Colors.deepPurple,
            ),
            labelText: widget.labelText,
            errorText: widget.errorText,
            suffixIcon: IconButton(
              icon: Icon(_isPasswordHidden ? Icons.visibility : Icons.visibility_off, color: _isPasswordHidden ? Colors.grey : Colors.deepPurple),
              onPressed: _togglePasswordView,
            )),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

}
