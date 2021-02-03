import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/journeys/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class EmailOpenSignupButton extends StatelessWidget {
  const EmailOpenSignupButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupScreen())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(TranslationConstants.not_account.translate(context)),
          Text(
            TranslationConstants.signup_title.translate(context),
            style: TextStyle(color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
