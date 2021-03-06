import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class EmailOpenLoginButton extends StatelessWidget {
  const EmailOpenLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.pop(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(TranslationConstants.alreadyAccount.translate(context)),
          Text(
            TranslationConstants.loginTitle.translate(context),
            style: TextStyle(color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
