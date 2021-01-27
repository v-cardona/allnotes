import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  const SubmitButton({Key key, @required this.text, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_80.w, vertical: Sizes.dimen_8.h),
        child: Text(text),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dimen_5.w),
      ),
      elevation: 0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }
}
